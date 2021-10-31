<?php
/**
 * File name: QuizScheduleController.php
 * Last modified: 18/07/21, 12:11 AM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use App\Models\Quiz;
use App\Models\QuizSchedule;
use App\Repositories\QuestionRepository;
use App\Repositories\UserQuizRepository;
use App\Settings\LocalizationSettings;
use App\Transformers\Platform\QuizDetailTransformer;
use App\Transformers\Platform\QuizScheduleDetailTransformer;
use Carbon\Carbon;
use Inertia\Inertia;

class QuizScheduleController extends Controller
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
     * Load Quiz Schedule Instructions Page
     *
     * @param $slug
     * @param $schedule
     * @param LocalizationSettings $localization
     * @return \Inertia\Response
     */
    public function instructions($slug, $schedule, LocalizationSettings $localization)
    {
        $quizSchedule = QuizSchedule::with('userGroups:id,name')->where('code', $schedule)->firstOrFail();

        // Load quiz with unfinished sessions
        $quiz = Quiz::where('slug', $slug)
            ->published()
            ->with(['subCategory:id,name', 'quizType:id,name'])
            ->withCount(['sessions' => function ($query) use ($quizSchedule) {
                $query->where('user_id', auth()->user()->id)->where('quiz_schedule_id', $quizSchedule->id)->where('status', '=', 'started');
            }])
            ->firstOrFail();

        $scheduleUserGroups = $quizSchedule->userGroups()->pluck('id');
        $authUserGroups = auth()->user()->userGroups()->pluck('id');

        // check user exists in quiz schedule user groups
        $userHasAccess = count(array_intersect($scheduleUserGroups->toArray(), $authUserGroups->toArray())) > 0;

        // check access is open
        $allowAccess = false;
        $closesAt = '';
        $now = Carbon::now()->timezone($localization->default_timezone);

        if($quizSchedule->schedule_type == 'fixed') {
            $grace = $quizSchedule->starts_at->addMinutes($quizSchedule->grace_period);
            $allowAccess = $now->between($quizSchedule->starts_at, $grace);
            $closesAt = $grace->toDayDateTimeString();
        }

        if($quizSchedule->schedule_type == 'flexible') {
            $allowAccess = $now->between($quizSchedule->starts_at, $quizSchedule->ends_at);
            $closesAt = $quizSchedule->ends_at->toDayDateTimeString();
        }

        // Countdown timer
        $startsIn =  $now->diffInSeconds($quizSchedule->starts_at, false);

        return Inertia::render('User/QuizScheduleInstructions', [
            'quiz' => fractal($quiz, new QuizDetailTransformer())->toArray()['data'],
            'schedule' => fractal($quizSchedule, new QuizScheduleDetailTransformer())->toArray()['data'],
            'instructions' => $this->repository->getInstructions($quiz),
            'userHasAccess' => $userHasAccess,
            'startsIn' => $startsIn,
            'allowAccess' => $allowAccess,
            'closesAt' => $closesAt
        ]);
    }

    /**
     * Create or Load a Quiz Session of a schedule and redirect to quiz screen
     *
     * @param Quiz $quiz
     * @param $schedule
     * @return \Illuminate\Http\RedirectResponse
     */
    public function initQuizSchedule(Quiz $quiz, $schedule)
    {
        $quizSchedule = QuizSchedule::with('userGroups:id,name')->where('code', $schedule)->firstOrFail();

        // Load completed quiz sessions in this schedule
        $quiz->loadCount(['sessions' => function ($query) use ($quizSchedule) {
            $query->where('user_id', auth()->user()->id)->where('quiz_schedule_id', $quizSchedule->id)->where('status', 'completed');
        }]);

        $scheduleUserGroups = $quizSchedule->userGroups()->pluck('id');
        $authUserGroups = auth()->user()->userGroups()->pluck('id');

        // check user exists in quiz schedule user groups
        $userHasAccess = count(array_intersect($scheduleUserGroups->toArray(), $authUserGroups->toArray())) > 0;
        if(!$userHasAccess) {
            return redirect()->back()->with('errorMessage', 'You don\'t have access to this quiz schedule.');
        }

        // Check if any uncompleted sessions
        if($quiz->sessions()->where('status', '=', 'started')->where('quiz_schedule_id', $quizSchedule->id)->count() > 0) {
            $session = $this->repository->getScheduleSession($quiz, $quizSchedule->id);
        } else {
            // Restrict quiz schedule attempt to one time
            if($quiz->sessions_count >= 1) {
                return redirect()->back()->with('errorMessage', 'You have already completed this quiz schedule.');
            }

            // Check redeem eligibility
            if($quiz->can_redeem) {
                if(auth()->user()->balance < $quiz->points_required) {
                    return redirect()->back()
                        ->with('errorMessage', 'Insufficient points in your wallet. Wallet Balance is '.auth()->user()->balance.' XP. Required Points are '.$quiz->points_required.' XP.');
                }
            }

            $session = $this->repository->createScheduleSession($quiz, $quizSchedule, $this->questionRepository,);

            if($session && $quiz->can_redeem) {
                auth()->user()->withdraw($quiz->points_required, [
                    'session' => $session->code,
                    'description' => 'Attempt of Quiz ' . $quiz->title,
                ]);
            }
        }

        return redirect()->route('go_to_quiz', ['quiz' => $quiz->slug, 'session' => $session->code]);
    }
}
