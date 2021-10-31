<?php
/**
 * File name: PracticeController.php
 * Last modified: 18/07/21, 3:06 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Controllers\User;

use App\Filters\PracticeSetFilters;
use App\Http\Controllers\Controller;
use App\Models\PracticeSession;
use App\Models\PracticeSet;
use App\Models\Question;
use App\Models\Section;
use App\Models\SubCategory;
use App\Repositories\QuestionRepository;
use App\Repositories\UserPracticeSetRepository;
use App\Transformers\Platform\PracticeQuestionTransformer;
use App\Transformers\Platform\PracticeSetCardTransformer;
use App\Transformers\Platform\PracticeSolutionTransformer;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class PracticeController extends Controller
{
    private UserPracticeSetRepository $repository;
    private QuestionRepository $questionRepository;

    public function __construct(UserPracticeSetRepository $repository, QuestionRepository $questionRepository)
    {
        $this->middleware(['role:guest|student|employee']);
        $this->repository = $repository;
        $this->questionRepository = $questionRepository;
    }

    /**
     * View available practice sets for a section
     *
     * @param SubCategory $category
     * @param $section
     * @return \Inertia\Response
     */
    public function practiceSets(SubCategory $category, $section)
    {
        $section = Section::where('slug', $section)->firstOrFail();
        return Inertia::render('User/PracticeSets', [
            'category' => $category,
            'section' => $section,
        ]);
    }

    /**
     * Fetch practice sets for the practice sets screen
     *
     * @param SubCategory $category
     * @param $section
     * @param PracticeSetFilters $filters
     * @return \Illuminate\Http\JsonResponse
     */
    public function fetchPracticeSets(SubCategory $category, $section, PracticeSetFilters $filters)
    {
        $section = Section::where('slug', $section)->firstOrFail();
        $sets = fractal($section->practiceSets()->filter($filters)->with('skill:id,name')->has('questions')
            ->where('sub_category_id', $category->id)->where('practice_sets.is_active', true)->paginate(20), new PracticeSetCardTransformer())
            ->toArray();

        return response()->json([
            'sets' => $sets
        ], 200);
    }

    /**
     * Create or Load a Practice Session and redirect to practice screen
     *
     * @param PracticeSet $practiceSet
     * @return \Illuminate\Http\RedirectResponse
     */
    public function initPracticeSet(PracticeSet $practiceSet)
    {
        $practiceSet->loadCount(['sessions' => function ($query) {
            $query->where('user_id', auth()->user()->id);
        }]);

        if($practiceSet->sessions_count > 0) {
            $session = $this->repository->getSession($practiceSet);
        } else {
            $session = $this->repository->createSession($practiceSet);
        }

        if($session->status == 'completed') {
            return redirect()->route('get_practice_session_analysis', ['practiceSet' => $practiceSet->slug, 'session' => $session->code])
                ->with('successMessage', 'You\'ve completed this practice set');
        }

        return redirect()->route('go_to_practice', ['practiceSet' => $practiceSet->slug, 'session' => $session->code]);
    }

    /**
     * Go To Practice Screen
     *
     * @param PracticeSet $practiceSet
     * @param $session
     * @return \Inertia\Response
     */
    public function goToPractice(PracticeSet $practiceSet, $session)
    {
        $session = PracticeSession::where('code', $session)->firstOrFail();
        return Inertia::render('User/PracticeScreen', [
            'practiceSet' => $practiceSet->only('code', 'title', 'slug', 'total_questions'),
            'session' => $session,
        ]);
    }

    /**
     * Fetch practice set questions with session questions
     *
     * @param PracticeSet $practiceSet
     * @param $session
     * @return \Illuminate\Http\JsonResponse
     */
    public function getPracticeQuestions(PracticeSet $practiceSet, $session)
    {
        $session = PracticeSession::with('questions')->where('code', $session)->firstOrFail();

        $questions = fractal($practiceSet->questions()->with(['questionType:id,name,code', 'skill:id,name', 'comprehensionPassage:id,body',
            'practiceSessions' => function($query) use ($session) {
                $query->where('practice_session_id', $session->id);
            }])->paginate(5),
            new PracticeQuestionTransformer())->toArray();

        return response()->json([
            'questions' => $questions['data'],
            'pagination' => $questions['meta']['pagination'],
            'answered' => $session->questions()->wherePivot('status', '=', 'answered')->count(),
        ], 200);
    }

    /**
     * Check the user submitted answer is correct or not and update session accordingly
     *
     * @param Request $request
     * @param PracticeSet $practiceSet
     * @param $session
     * @return \Illuminate\Http\JsonResponse
     */
    public function checkAnswer(Request $request, PracticeSet $practiceSet, $session)
    {
        $session = PracticeSession::select(['id', 'code', 'practice_set_id', 'total_time_taken', 'total_points_earned', 'percentage_completed'])
            ->where('code', $session)
            ->firstOrFail();

        $question = Question::select(['id', 'question', 'options', 'correct_answer', 'default_marks', 'solution', 'question_type_id'])
            ->with(['questionType:id,name,code'])
            ->where('code', $request->question_id)
            ->firstOrFail();

        $isCorrect = $this->questionRepository->evaluateAnswer($question, $request->user_answer);

        $correctAnswer = $this->questionRepository->formatCorrectAnswer($question, $request->user_answer);

        $pointsEarned = $practiceSet->auto_grading ? $question->default_marks : $practiceSet->correct_marks;

        /*Insert or Update Session Question*/
        DB::table('practice_session_questions')->upsert([
            'question_id' => $question->id,
            'practice_session_id' => $session->id,
            'original_question' => formatQuestionProperty($question->question, $question->questionType->code),
            'options' => serialize(formatOptionsProperty($question->options, $question->questionType->code, $question->question)),
            'user_answer' => serialize($request->user_answer),
            'correct_answer' => serialize($correctAnswer),
            'time_taken' => $request->time_taken,
            'points_earned' => $isCorrect ? $pointsEarned : 0,
            'is_correct' => $isCorrect,
            'status' => 'answered'
        ],
            ['question_id', 'practice_session_id'],
            ['user_answer', 'is_correct', 'time_taken', 'status']
        );

        /*Update Session */
        if($isCorrect) {
            $session->total_points_earned = $session->total_points_earned + $pointsEarned;
        }
        $totalAnswered = $session->questions()->wherePivot('status', '=', 'answered')->count();

        $session->percentage_completed = $totalAnswered != 0 ? round(($totalAnswered/$practiceSet->total_questions) * 100, 2) : 0;
        $session->total_time_taken = $request->total_time_taken;
        $session->update();

        return response()->json([
            'is_correct' => $isCorrect,
            'status' => 'answered',
            'solution' => $question->solution,
            'ca' => $correctAnswer,
            'points_earned' => $isCorrect ? $pointsEarned : 0,
            'total_points_earned' => $session->total_points_earned,
            'answered' => $totalAnswered
        ], 200);
    }

    /**
     * Finish Practice Session and Redirect to Analysis Screen
     *
     * @param PracticeSet $practiceSet
     * @param $session
     * @return \Illuminate\Http\RedirectResponse
     * @throws \Throwable
     */
    public function finish(PracticeSet $practiceSet, $session)
    {
        $session = PracticeSession::with('questions')->where('code', $session)->firstOrFail();
        if($session->total_points_earned > 0 && $session->status != 'completed') {
            auth()->user()->deposit($session->total_points_earned, ['description' => $practiceSet->title, 'session' => $session->code]);
        }
        $session->percentage_completed = round(100, 2);
        $session->status = 'completed';
        $session->completed_at = Carbon::now()->toDateTimeString();
        $session->results = $this->repository->sessionAnalytics($session, $practiceSet->total_questions);
        $session->update();

        return redirect()->route('get_practice_session_analysis', ['practiceSet' => $practiceSet->slug, 'session' => $session->code]);
    }

    /**
     * Practice Session Analysis and Progress Status
     *
     * @param PracticeSet $practiceSet
     * @param $session
     * @return \Inertia\Response
     */
    public function analysis(PracticeSet $practiceSet, $session)
    {
        $session = PracticeSession::with('questions')->where('code', $session)->firstOrFail();
        if(request()->has('total_time_taken')) {
            $session->total_time_taken = request()->get('total_time_taken');
            $session->update();
        }
        return Inertia::render('User/PracticeAnalysis', [
            'practiceSet' => $practiceSet->only('code', 'title', 'slug', 'total_questions'),
            'session' => $session->only('code', 'total_time_taken', 'total_points_earned', 'status'),
            'analytics' => $session->status == 'completed' ? $session->results : $this->repository->sessionAnalytics($session, $practiceSet->total_questions)
        ]);
    }

    /**
     * Get Practice Session solutions api endpoint
     *
     * @param PracticeSet $practiceSet
     * @param $session
     * @return \Illuminate\Http\JsonResponse
     */
    public function solutions(PracticeSet $practiceSet, $session)
    {
        $session = PracticeSession::with('questions')->where('code', $session)->firstOrFail();

        $questions = fractal($session->questions()->with(['questionType:id,name,code', 'skill:id,name'])
            ->get(['id','code', 'question', 'question_type_id', 'skill_id', 'solution']),
            new PracticeSolutionTransformer())->toArray();

        return response()->json([
            'questions' => $questions['data'],
        ], 200);
    }
}
