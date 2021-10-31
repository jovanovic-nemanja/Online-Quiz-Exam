<?php
/**
 * File name: DashboardController.php
 * Last modified: 14/07/21, 7:59 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Controllers\Instructor;

use App\Http\Controllers\Controller;
use App\Models\PracticeSet;
use App\Models\Question;
use App\Models\Quiz;
use App\Models\User;
use Inertia\Inertia;

class DashboardController extends Controller
{
    public function __construct()
    {
        $this->middleware(['role:instructor']);
    }

    /**
     * Get Dashboard Statistics
     *
     * @return \Inertia\Response
     */
    public function index()
    {
        $stats = [
            [
                'key' => 'total_users',
                'title' => 'Total Users',
                'count' => User::active()->count()
            ],
            [
                'key' => 'total_questions',
                'title' => 'Total Questions',
                'count' => Question::active()->count()
            ],
            [
                'key' => 'total_quizzes',
                'title' => 'Total Quizzes',
                'count' => Quiz::published()->count()
            ],
            [
                'key' => 'total_practice_sets',
                'title' => 'Total Practice Sets',
                'count' => PracticeSet::published()->count()
            ]
        ];
        return Inertia::render('Instructor/Dashboard', [
            'stats' => $stats
        ]);
    }
}
