<?php
/**
 * File name: QuizController.php
 * Last modified: 18/07/21, 12:11 AM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use App\Http\Requests\Platform\QuizUpdateAnswerRequest;
use App\Models\Question;
use App\Models\Quiz;
use App\Models\QuizSession;
use App\Models\Disc;
use App\Repositories\QuestionRepository;
use App\Repositories\UserQuizRepository;
use App\Settings\LocalizationSettings;
use App\Settings\SiteSettings;
use App\Transformers\Admin\QuizScoreReportTransformer;
use App\Transformers\Platform\QuizDetailTransformer;
use App\Transformers\Platform\QuizQuestionTransformer;
use App\Transformers\Platform\QuizSolutionTransformer;
use Barryvdh\DomPDF\Facade as PDF;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class QuizController extends Controller
{
    private UserQuizRepository $repository;
    private QuestionRepository $questionRepository;

    public function __construct(UserQuizRepository $repository, QuestionRepository $questionRepository)
    {
        $this->middleware(['role:guest|student|employee']);
        $this->repository = $repository;
        $this->questionRepository = $questionRepository;
    }

    /**
     * Load Quiz Instructions Page
     *
     * @param $slug
     * @return \Inertia\Response
     */
    public function instructions($slug)
    {
        $quiz = Quiz::where('slug', $slug)
            ->published()
            ->isPublic()
            ->with(['subCategory:id,name', 'quizType:id,name'])
            ->withCount(['sessions' => function ($query) {
                $query->where('user_id', auth()->user()->id)->where('status', '=', 'started');
            }])
            ->firstOrFail();

        return Inertia::render('User/QuizInstructions', [
            'quiz' => fractal($quiz, new QuizDetailTransformer())->toArray()['data'],
            'instructions' => $this->repository->getInstructions($quiz)
        ]);
    }

    /**
     * Create or Load a Quiz Session and redirect to quiz screen
     *
     * @param Quiz $quiz
     * @return \Illuminate\Http\RedirectResponse
     */
    public function initQuiz(Quiz $quiz)
    {
        // Load completed quiz sessions
        $quiz->loadCount(['sessions' => function ($query) {
            $query->where('user_id', auth()->user()->id)->where('status', 'completed');
        }]);

        // Check if any uncompleted sessions
        if($quiz->sessions()->where('status', '=', 'started')->count() > 0) {
            $session = $this->repository->getSession($quiz);
        } else {
            // Check restricted attempts
            if($quiz->settings->get('restrict_attempts')) {
                if($quiz->sessions_count >= $quiz->settings->get('restrict_attempts')) {
                    return redirect()->back()->with('errorMessage', 'You have exceeded maximum no. of attempts for this test.');
                }
            }

            // Check redeem eligibility
            if($quiz->can_redeem) {
                if(auth()->user()->balance < $quiz->points_required) {
                    return redirect()->back()
                        ->with('errorMessage', 'Insufficient points in your wallet. Wallet Balance is '.auth()->user()->balance.' XP. Required Points are '.$quiz->points_required.' XP.');
                }
            }

            $session = $this->repository->createSession($quiz, $this->questionRepository);
            $questions = $quiz->questions()->with(['questionType:id,name,code'])->get();
            $i = 0;
            foreach ($questions as $question) {
                $answer = "not_answered";

                DB::table('disc')->insert([
                    'user_id' => auth()->user()->id,
                    'question_id' => $question->id,
                    'session_code' => $session->code,
                    'current_question' => $i,
                    'answer' => $answer,
                ]);

                $i++;
            }

            if($session && $quiz->can_redeem) {
                auth()->user()->withdraw($quiz->points_required, [
                    'session' => $session->code,
                    'description' => 'Attempt of Quiz ' . $quiz->title,
                ]);
            }
        }

        return redirect()->route('go_to_quiz', ['quiz' => $quiz->slug, 'session' => $session->code]);
    }

    /**
     * Go To Quiz Screen
     *
     * @param Quiz $quiz
     * @param $session
     * @return \Illuminate\Http\RedirectResponse|\Inertia\Response
     */
    public function goToQuiz(Quiz $quiz, $session)
    {
        $session = QuizSession::with('questions')->where('code', $session)->firstOrFail();

        $now = Carbon::now();

        $remainingTime =  $now->diffInSeconds($session->ends_at, false);

        if($session->status !== 'completed' && $remainingTime < 15) {
            $session->results = $this->repository->sessionResults($session, $quiz);
            $session->status = 'completed';
            $session->completed_at = Carbon::now()->toDateTimeString();
            $session->update();

            return redirect()->route('quiz_thank_you', ['quiz' => $quiz->slug, 'session' => $session->code]);
        }

        return Inertia::render('User/QuizScreen', [
            'quiz' => $quiz->only('code', 'title', 'slug', 'total_questions', 'settings'),
            'session' => $session,
            'remainingTime' => $remainingTime,
            'answeredQuestions' => $session->questions()->wherePivot('status', '=', 'answered')->count()
        ]);
    }

    /**
     * Get quiz questions api endpoint
     *
     * @param Quiz $quiz
     * @param $session
     * @return \Illuminate\Http\JsonResponse
     */
    public function getQuizQuestions(Quiz $quiz, $session)
    {
        $session = QuizSession::with('questions')->where('code', $session)->firstOrFail();

        $questions = fractal($session->questions()->with(['questionType:id,name,code', 'skill:id,name', 'comprehensionPassage:id,body'])->get(),
            new QuizQuestionTransformer())->toArray();

        return response()->json([
            'questions' => $questions['data'],
        ], 200);
    }

    /**
     * Check the user submitted answer is correct or not and update session accordingly
     *
     * @param QuizUpdateAnswerRequest $request
     * @param Quiz $quiz
     * @param $session
     * @return \Illuminate\Http\JsonResponse
     */
    public function updateAnswer(QuizUpdateAnswerRequest $request, Quiz $quiz, $session)
    {
        $session = QuizSession::select(['id', 'code', 'quiz_id', 'total_time_taken', 'current_question'])
            ->where('code', $session)
            ->firstOrFail();

        $question = Question::select(['id', 'question', 'options', 'correct_answer', 'default_marks', 'solution', 'question_type_id'])
            ->with(['questionType:id,name,code'])
            ->where('code', $request->question_id)
            ->firstOrFail();

        $isCorrect = false;
        $correctAnswer = null;
        $marksEarned = 0;
        $marksDeducted = 0;

        if($request->status === 'answered') {
            $isCorrect = $this->questionRepository->evaluateAnswer($question, $request->user_answer);

            // Calculate Positive & Negative Marks based on preferences
            if($isCorrect) {
                $marksEarned = $quiz->settings->get('auto_grading', true) ? $question->default_marks : $quiz->settings->get('correct_marks');
            } else {
                if($quiz->settings->get('enable_negative_marking', false)) {
                    if($quiz->settings->get('negative_marking_type', 'fixed') == 'fixed') {
                        $marksDeducted = $quiz->settings->get('negative_marks', 0);
                    } else {
                        $marksDeducted = $quiz->settings->get('negative_marks', 0) != 0 ? round(($marks*$quiz->settings->get('negative_marks', 0))  / 100, 2) : 0;
                    }
                }
            }
        }

        /*Insert or Update Session Question*/
        DB::table('quiz_session_questions')->upsert([
            'question_id' => $question->id,
            'original_question' => formatQuestionProperty($question->question, $question->questionType->code),
            'quiz_session_id' => $session->id,
            'user_answer' => serialize($request->user_answer),
            'time_taken' => $request->time_taken,
            'is_correct' => $isCorrect,
            'status' => $request->status,
            'marks_earned' => $marksEarned,
            'marks_deducted' => $marksDeducted
        ],
            ['question_id', 'quiz_session_id'],
            ['user_answer', 'time_taken', 'is_correct', 'status', 'marks_earned', 'marks_deducted']
        );

        $update_record = Disc::where('user_id', auth()->user()->id)->where('session_code', $session->code)->where('question_id', $question->id)->update(['answer' => $request->user_answer]);

        /*Update Session */
        $session->current_question = $request->current_question;
        $session->total_time_taken = $request->total_time_taken;
        $session->update();

        return response()->json([
            'answered' => $session->questions()->wherePivot('status', '=', 'answered')->count()
        ], 200);
    }

    /**
     * Finish the quiz
     *
     * @param Quiz $quiz
     * @param $session
     * @return \Illuminate\Http\RedirectResponse
     */
    public function finish(Quiz $quiz, $session)
    {
        $session = QuizSession::with('questions')->where('code', $session)->firstOrFail();

        $session->results = $this->repository->sessionResults($session, $quiz);
        $session->status = 'completed';
        $session->completed_at = Carbon::now()->toDateTimeString();
        $session->update();

        return redirect()->route('quiz_thank_you', ['quiz' => $quiz->slug, 'session' => $session->code]);
    }

    /**
     * Quiz thank you screen
     *
     * @param Quiz $quiz
     * @param $session
     * @return \Inertia\Response
     */
    public function thankYou(Quiz $quiz, $session)
    {
        $session = QuizSession::where('code', $session)->firstOrFail();

        return Inertia::render('User/QuizThanksScreen', [
            'quiz' => $quiz->only('code', 'title', 'slug', 'total_marks','quiz_type_id'),
            'type' => $quiz->quizType,
            'session' => $session,
        ]);
    }

    /**
     * Quiz Session Analysis and Progress Status
     *
     * @param Quiz $quiz
     * @param $session
     * @return \Inertia\Response
     */
    public function results(Quiz $quiz, $session)
    {
        $session = QuizSession::with('questions')->where('code', $session)->firstOrFail();
        return Inertia::render('User/QuizResults', [
            'quiz' => $quiz->only('code', 'title', 'slug', 'total_questions', 'total_marks', 'settings','quiz_type_id'),
            'type' => $quiz->quizType,
            'session' => $session->only('code', 'total_time_taken', 'results', 'status'),
        ]);
    }

    /**
     * Get quiz solutions api endpoint
     *
     * @param Quiz $quiz
     * @param $session
     * @return \Illuminate\Http\JsonResponse
     */
    public function solutions(Quiz $quiz, $session)
    {
        $session = QuizSession::where('code', $session)->firstOrFail();

        $questions = fractal($session->questions()->with(['questionType:id,name,code', 'skill:id,name'])
            ->get(['id','code', 'question', 'question_type_id', 'skill_id', 'solution']),
            new QuizSolutionTransformer())->toArray();

        return response()->json([
            'questions' => $questions['data'],
        ], 200);
    }

    /**
     * User Quiz Session Export PDF
     *
     * @param Quiz $quiz
     * @param $session
     * @param LocalizationSettings $localization
     * @param SiteSettings $settings
     * @return \Illuminate\Http\Response
     */
    public function exportPDF(Quiz $quiz, $session, LocalizationSettings $localization, SiteSettings $settings)
    {
        $session = QuizSession::with('user')->where('code', $session)->firstOrFail();

        $now = Carbon::now()->timezone($localization->default_timezone);
        $user = auth()->user()->first_name.' '.auth()->user()->last_name;

        $pdf = PDF::loadView('pdf.quiz-session-report', [
            'quiz' => $quiz->only('code', 'title'),
            'session' => fractal($session, new QuizScoreReportTransformer())->toArray()['data'],
            'footer' => "* Report Generated from {$settings->app_name} by {$user} on {$now->toDayDateTimeString()}",
            'logo' => url('storage/'.$settings->logo_path)
        ]);

        return $pdf->download("report-{$session->code}.pdf");
    }
}
