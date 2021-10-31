<?php
/**
 * File name: user.php
 * Last modified: 20/07/21, 2:27 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

use App\Http\Controllers\User\DashboardController;
use App\Http\Controllers\User\PracticeController;
use App\Http\Controllers\User\QuizController;
use App\Http\Controllers\User\ProgressController;
use App\Http\Controllers\User\QuizScheduleController;

Route::middleware(['auth:sanctum', 'verified'])->group(function () {

    Route::get('/dashboard', [DashboardController::class, 'index'])->name('user_dashboard');
    Route::get('/learn-practice', [DashboardController::class, 'practice'])->name('practice_dashboard');
    Route::get('/quizzes', [DashboardController::class, 'quiz'])->name('quiz_dashboard');
    Route::get('/quizzes/{type:slug}', [DashboardController::class, 'quizzesByType'])->name('quizzes_by_type');
    Route::get('/fetch-quizzes-by/{type:slug}', [DashboardController::class, 'fetchQuizzesByType'])->name('fetch_quizzes_by_type');
    Route::get('/live-quizzes', [DashboardController::class, 'liveQuizzes'])->name('live_quizzes');
    Route::get('/fetch-live-quizzes', [DashboardController::class, 'fetchLiveQuizzes'])->name('fetch_live_quizzes');

    /*
    |--------------------------------------------------------------------------
    | User Practice Routes
    |--------------------------------------------------------------------------
    */
    Route::get('/learn-practice/{category:slug}/{section}', [PracticeController::class, 'practiceSets'])->name('section_practice_sets');
    Route::get('/fetch-practice-sets/{category:slug}/{section}', [PracticeController::class, 'fetchPracticeSets'])->name('fetch_practice_sets');
    Route::get('/practice/{practiceSet:slug}/init', [PracticeController::class, 'initPracticeSet'])->name('init_practice_set');
    Route::get('/practice/{practiceSet:slug}/{session}', [PracticeController::class, 'goToPractice'])->name('go_to_practice');
    Route::get('/practice/{practiceSet:slug}/questions/{session}', [PracticeController::class, 'getPracticeQuestions'])->name('fetch_practice_questions');
    Route::post('/check_practice_answer/{practiceSet:slug}/{session}', [PracticeController::class, 'checkAnswer'])->name('check_practice_answer');
    Route::get('/practice/{practiceSet:slug}/analysis/{session}', [PracticeController::class, 'analysis'])->name('get_practice_session_analysis');
    Route::post('/practice/{practiceSet:slug}/analysis/{session}', [PracticeController::class, 'analysis'])->name('practice_session_analysis');
    Route::post('/practice/{practiceSet:slug}/finish/{session}', [PracticeController::class, 'finish'])->name('finish_practice_session');
    Route::get('/practice/{practiceSet:slug}/solutions/{session}', [PracticeController::class, 'solutions'])->name('fetch_practice_set_solutions');

    /*
    |--------------------------------------------------------------------------
    | User Quiz Routes
    |--------------------------------------------------------------------------
    */
    Route::get('/quiz/{quiz:slug}/instructions', [QuizController::class, 'instructions'])->name('quiz_instructions');
    Route::get('/quiz/{quiz:slug}/init', [QuizController::class, 'initQuiz'])->name('init_quiz');

    Route::get('/quiz/{quiz:slug}/{schedule}/instructions', [QuizScheduleController::class, 'instructions'])->name('quiz_schedule_instructions');
    Route::get('/quiz/{quiz:slug}/{schedule}/init', [QuizScheduleController::class, 'initQuizSchedule'])->name('init_quiz_schedule');

    Route::get('/quiz/{quiz:slug}/{session}', [QuizController::class, 'goToQuiz'])->name('go_to_quiz');
    Route::get('/quiz/{quiz:slug}/questions/{session}', [QuizController::class, 'getQuizQuestions'])->name('fetch_quiz_questions');
    Route::post('/update_quiz_answer/{quiz:slug}/{session}', [QuizController::class, 'updateAnswer'])->name('update_quiz_answer');
    Route::post('/quiz/{quiz:slug}/finish/{session}', [QuizController::class, 'finish'])->name('finish_quiz_session');
    Route::get('/quiz/{quiz:slug}/thank-you/{session}', [QuizController::class, 'thankYou'])->name('quiz_thank_you');
    Route::get('/quiz/{quiz:slug}/results/{session}', [QuizController::class, 'results'])->name('quiz_results');
    Route::get('/quiz/{quiz:slug}/solutions/{session}', [QuizController::class, 'solutions'])->name('fetch_quiz_solutions');
    Route::get('/quiz/{quiz:slug}/download-report/{session}', [QuizController::class, 'exportPDF'])->name('download_quiz_report');

    /*
    |--------------------------------------------------------------------------
    | User Progress Routes
    |--------------------------------------------------------------------------
    */
    Route::get('/my-progress', [ProgressController::class, 'myProgress'])->name('my_progress');
    Route::get('/my-practice', [ProgressController::class, 'myPractice'])->name('my_practice');
    Route::get('/my-quizzes', [ProgressController::class, 'myQuizzes'])->name('my_quizzes');
});
