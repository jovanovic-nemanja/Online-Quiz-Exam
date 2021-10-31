<?php
/**
 * File name: admin.php
 * Last modified: 20/07/21, 2:27 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

use App\Http\Controllers\Admin\UserGroupCrudController;
use App\Http\Controllers\Admin\UserCrudController;
use App\Http\Controllers\Admin\PracticeSetCrudController;
use App\Http\Controllers\Admin\CategoryCrudController;
use App\Http\Controllers\Admin\SubCategoryCrudController;
use App\Http\Controllers\Admin\SectionCrudController;
use App\Http\Controllers\Admin\SkillCrudController;
use App\Http\Controllers\Admin\TopicCrudController;
use App\Http\Controllers\Admin\FileController;
use App\Http\Controllers\Admin\QuestionCrudController;
use App\Http\Controllers\Admin\ComprehensionCrudController;
use App\Http\Controllers\Admin\QuestionTypeController;
use App\Http\Controllers\Admin\QuestionImportController;
use App\Http\Controllers\Admin\QuizCrudController;
use App\Http\Controllers\Admin\DashboardController;
use App\Http\Controllers\Admin\SettingController;
use App\Http\Controllers\Admin\PracticeSetQuestionController;
use App\Http\Controllers\Admin\QuizQuestionController;
use App\Http\Controllers\Admin\QuizScheduleCrudController;
use App\Http\Controllers\Admin\MaintenanceController;
use App\Http\Controllers\Admin\QuizAnalyticsController;
use App\Http\Controllers\Admin\PracticeAnalyticsController;
use App\Http\Controllers\AppUpdateController;

/*
|--------------------------------------------------------------------------
| Admin Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::middleware(['auth:sanctum', 'verified'])->prefix('admin')->group(function () {
    Route::get('/dashboard', [DashboardController::class, 'index'])->name('admin_dashboard');

    /*
    |--------------------------------------------------------------------------
    | CRUD Routes
    |--------------------------------------------------------------------------
    */
    Route::resource('users', UserCrudController::class);
    Route::resource('user-groups', UserGroupCrudController::class);
    Route::resource('categories', CategoryCrudController::class);
    Route::resource('sections', SectionCrudController::class);
    Route::resource('skills', SkillCrudController::class);
    Route::resource('topics', TopicCrudController::class);
    Route::resource('comprehensions', ComprehensionCrudController::class);

    Route::resource('sub-categories', SubCategoryCrudController::class);
    Route::get('fetch_sub_category_sections/{id}', [SubCategoryCrudController::class, 'fetchSections'])->name('fetch_sub_category_sections');
    Route::post('update_sub_category_sections/{id}', [SubCategoryCrudController::class, 'updateSections'])->name('update_sub_category_sections');

    /*
    |--------------------------------------------------------------------------
    | Question Routes
    |--------------------------------------------------------------------------
    */
    Route::resource('questions', QuestionCrudController::class);
    Route::get('questions/{id}/settings', [QuestionCrudController::class, 'settings'])->name('question_settings');
    Route::post('questions/{id}/settings', [QuestionCrudController::class, 'updateSettings'])->name('update_question_settings');
    Route::get('questions/{id}/solution', [QuestionCrudController::class, 'solution'])->name('question_solution');
    Route::post('questions/{id}/solution', [QuestionCrudController::class, 'updateSolution'])->name('update_question_solution');
    Route::get('questions/{id}/attachment', [QuestionCrudController::class, 'attachment'])->name('question_attachment');
    Route::post('questions/{id}/attachment', [QuestionCrudController::class, 'updateAttachment'])->name('update_question_attachment');

    Route::get('import-questions', [QuestionImportController::class, 'initiateImport'])->name('initiate_import_questions');
    Route::post('import-questions/{skill}', [QuestionImportController::class, 'import'])->name('import_questions');
    Route::get('question-types', [QuestionTypeController::class, 'index'])->name('question-types.index');

    /*
    |--------------------------------------------------------------------------
    | Quiz Routes
    |--------------------------------------------------------------------------
    */
    Route::resource('quizzes', QuizCrudController::class);
    Route::resource('quizzes/{quiz}/schedules', QuizScheduleCrudController::class, ['as' => 'quizzes']);
    Route::get('quizzes/{quiz}/overall-report', [QuizAnalyticsController::class, 'overallReport'])->name('quizzes.overall_report');
    Route::get('quizzes/{quiz}/detailed-report', [QuizAnalyticsController::class, 'detailedReport'])->name('quizzes.detailed_report');

    Route::get('/quiz/{quiz:slug}/results/{session}', [QuizAnalyticsController::class, 'results'])->name('quiz_session_results');
    Route::get('/quiz/{quiz:slug}/solutions/{session}', [QuizAnalyticsController::class, 'solutions'])->name('fetch_quiz_session_solutions');

    Route::get('quizzes/{quiz}/export-report', [QuizAnalyticsController::class, 'exportReport'])->name('quizzes.export_report');
    Route::get('/quiz/{quiz:slug}/report/{session}', [QuizAnalyticsController::class, 'exportPDF'])->name('quiz_session_report');

    Route::get('/quizzes/{quiz}/settings', [QuizCrudController::class, 'settings'])->name('quizzes.settings');
    Route::post('/quizzes/{quiz}/settings', [QuizCrudController::class, 'updateSettings'])->name('quizzes.settings.update');

    Route::get('/quizzes/{quiz}/questions', [QuizQuestionController::class, 'index'])->name('quizzes.questions');
    Route::get('/quizzes/{quiz}/fetch-questions', [QuizQuestionController::class, 'fetchQuestions'])->name('quizzes.fetch_questions');
    Route::get('/quizzes/{quiz}/fetch-available-questions', [QuizQuestionController::class, 'fetchAvailableQuestions'])->name('quizzes.fetch_available_questions');
    Route::post('/quizzes/{quiz}/add-question', [QuizQuestionController::class, 'addQuestion'])->name('quizzes.add_question');
    Route::post('/quizzes/{quiz}/remove-question', [QuizQuestionController::class, 'removeQuestion'])->name('quizzes.remove_question');

    /*
    |--------------------------------------------------------------------------
    | Practice Set Routes
    |--------------------------------------------------------------------------
    */
    Route::resource('practice-sets', PracticeSetCrudController::class);
    Route::get('/practice-sets/{practice_set}/settings', [PracticeSetCrudController::class, 'settings'])->name('practice-sets.settings');
    Route::post('/practice-sets/{practice_set}/settings', [PracticeSetCrudController::class, 'updateSettings'])->name('practice-sets.settings.update');

    Route::get('/practice-sets/{practice_set}/questions', [PracticeSetQuestionController::class, 'index'])->name('practice-sets.questions');
    Route::get('/practice-sets/{practice_set}/fetch-questions', [PracticeSetQuestionController::class, 'fetchQuestions'])->name('practice-sets.fetch_questions');
    Route::get('/practice-sets/{practice_set}/fetch-available-questions', [PracticeSetQuestionController::class, 'fetchAvailableQuestions'])->name('practice-sets.fetch_available_questions');
    Route::post('/practice-sets/{practice_set}/add-question', [PracticeSetQuestionController::class, 'addQuestion'])->name('practice-sets.add_question');
    Route::post('/practice-sets/{practice_set}/remove-question', [PracticeSetQuestionController::class, 'removeQuestion'])->name('practice-sets.remove_question');

    Route::get('practice-sets/{practice_set}/overall-report', [PracticeAnalyticsController::class, 'overallReport'])->name('practice-sets.overall_report');
    Route::get('practice-sets/{practice_set}/detailed-report', [PracticeAnalyticsController::class, 'detailedReport'])->name('practice-sets.detailed_report');
    Route::get('practice-sets/{practice_set}/export-report', [PracticeAnalyticsController::class, 'exportReport'])->name('practice-sets.export_report');

    Route::get('/practice/{practice_set:slug}/analysis/{session}', [PracticeAnalyticsController::class, 'analysis'])->name('practice_session_results');
    Route::get('/practice/{practice_set:slug}/solutions/{session}', [PracticeAnalyticsController::class, 'solutions'])->name('fetch_practice_session_solutions');

    /*
    |--------------------------------------------------------------------------
    | Search Routes
    |--------------------------------------------------------------------------
    */
    Route::get('/search_quizzes', [QuizCrudController::class, 'search'])->name('search_quizzes');
    Route::get('/search_sections', [SectionCrudController::class, 'search'])->name('search_sections');
    Route::get('/search_skills', [SkillCrudController::class, 'search'])->name('search_skills');
    Route::get('/search_topics', [TopicCrudController::class, 'search'])->name('search_topics');
    Route::get('/search_comprehensions', [ComprehensionCrudController::class, 'search'])->name('search_comprehensions');
    Route::get('/search_sub_categories', [SubCategoryCrudController::class, 'search'])->name('search_sub_categories');

    /*
    |--------------------------------------------------------------------------
    | Setting Routes
    |--------------------------------------------------------------------------
    */
    Route::get('/general-settings', [SettingController::class, 'general'])->name('general_settings');
    Route::post('/update-site-settings', [SettingController::class, 'updateSiteSettings'])->name('update_site_settings');
    Route::post('/update-logo', [SettingController::class, 'updateLogo'])->name('update_logo');
    Route::post('/update-favicon', [SettingController::class, 'updateFavicon'])->name('update_favicon');

    Route::get('/localization-settings', [SettingController::class, 'localization'])->name('localization_settings');
    Route::post('/update-localization-settings', [SettingController::class, 'updateLocalizationSettings'])->name('update_localization_settings');

    Route::get('/email-settings', [SettingController::class, 'email'])->name('email_settings');
    Route::post('/update-email-settings', [SettingController::class, 'updateEmailSettings'])->name('update_email_settings');

    Route::get('/home-settings', [SettingController::class, 'home'])->name('home_page_settings');
    Route::post('/update-home-page-settings', [SettingController::class, 'updateHomePageSettings'])->name('update_home_page_settings');

    Route::get('/maintenance-settings', [MaintenanceController::class, 'index'])->name('maintenance_settings');
    Route::post('/maintenance/clear-cache', [MaintenanceController::class, 'clearCache'])->name('clear_cache');
    Route::post('/maintenance/expire-schedules', [MaintenanceController::class, 'expireSchedules'])->name('expire_schedules');
    Route::post('/maintenance/update', [AppUpdateController::class, 'onSuccessfulUpdate'])->name('fix_updates');

    /*
    |--------------------------------------------------------------------------
    | File Manager Routes
    |--------------------------------------------------------------------------
    */
    Route::get('/file-manager', [FileController::class, 'index'])->name('file-manager');
    Route::get('file-manager/ckeditor', [FileController::class, 'ckeditor'])->name('file-ckeditor');
    Route::get('file-manager/fm-button', [FileController::class, 'button'])->name('file-button');
});


