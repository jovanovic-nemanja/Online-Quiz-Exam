<?php
/**
 * File name: ProgressController.php
 * Last modified: 18/07/21, 12:07 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use App\Models\PracticeSession;
use App\Models\QuizSession;
use App\Repositories\UserRepository;
use App\Transformers\Platform\QuizSessionCardTransformer;
use App\Transformers\Platform\UserPracticeSessionTransformer;
use App\Transformers\Platform\UserQuizSessionTransformer;
use Inertia\Inertia;

class ProgressController extends Controller
{
    /**
     * @var UserRepository
     */
    private UserRepository $repository;

    public function __construct(UserRepository $repository)
    {
        $this->middleware(['role:guest|student|employee']);
        $this->repository = $repository;
    }

    /**
     * User My Progress Screen
     *
     * @return \Inertia\Response
     */
    public function myProgress()
    {
        // Fetch current user in-completed practice sessions
        $quizSessions = QuizSession::with(['quiz' => function($query) {
            $query->with('quizType:id,name');
        }, 'quizSchedule'])->where('user_id', auth()->user()->id)->pending()->get();

        return Inertia::render('User/MyProgress', [
            'steps' => $this->repository->getProgressNavigatorLinks('my_progress'),
            'quizSessions' => fractal($quizSessions, new QuizSessionCardTransformer())->toArray()['data']
        ]);
    }

    /**
     * User My Quizzes Screen
     *
     * @return \Inertia\Response
     */
    public function myQuizzes()
    {
        $sessions = QuizSession::with('quiz:id,slug,title')->where('status', '=', 'completed')
            ->paginate(request()->perPage != null ? request()->perPage : 10);

        return Inertia::render('User/MyQuizzes', [
            'steps' => $this->repository->getProgressNavigatorLinks('my_quizzes'),
            'quizSessions' => fractal($sessions, new UserQuizSessionTransformer())->toArray(),
        ]);
    }

    /**
     * User My Practice Screen
     *
     * @return \Inertia\Response
     */
    public function myPractice()
    {
        $sessions = PracticeSession::with('practiceSet:id,slug,title')->where('status', '=', 'completed')
            ->paginate(request()->perPage != null ? request()->perPage : 10);

        return Inertia::render('User/MyPractice', [
            'steps' => $this->repository->getProgressNavigatorLinks('my_practice'),
            'practiceSessions' => fractal($sessions, new UserPracticeSessionTransformer())->toArray(),
        ]);
    }
}
