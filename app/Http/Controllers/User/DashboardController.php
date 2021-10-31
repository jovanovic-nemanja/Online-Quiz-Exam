<?php
/**
 * File name: DashboardController.php
 * Last modified: 18/07/21, 3:59 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use App\Models\PracticeSession;
use App\Models\QuizSchedule;
use App\Models\QuizType;
use App\Models\SubCategory;
use App\Settings\LocalizationSettings;
use App\Transformers\Platform\PracticeSessionCardTransformer;
use App\Transformers\Platform\QuizCardTransformer;
use App\Transformers\Platform\QuizScheduleCardTransformer;
use App\Transformers\Platform\QuizTypeTransformer;
use App\Transformers\Platform\SubCategoryCardTransformer;
use Illuminate\Database\Eloquent\Builder;
use Inertia\Inertia;

class DashboardController extends Controller
{
    private LocalizationSettings $localizationSettings;

    public function __construct(LocalizationSettings $localizationSettings)
    {
        $this->middleware(['role:guest|student|employee']);
        $this->localizationSettings = $localizationSettings;
    }

    /**
     * User's Main Dashboard
     *
     * @return \Inertia\Response
     */
    public function index()
    {
        $userGroups = auth()->user()->userGroups()->pluck('id');

        // Fetch quizzes scheduled for current user via user groups
        $schedules = QuizSchedule::whereHas('userGroups', function (Builder $query) use ($userGroups) {
            $query->whereIn('user_group_id', $userGroups);
        })->with(['quiz' => function($builder) {
            $builder->with(['subCategory:id,name', 'quizType:id,name']);
        }])->orderBy('end_date', 'asc')->active()->limit(4)->get();

        // Fetch current user in-completed practice sessions
        $practiceSessions = PracticeSession::with(['practiceSet' => function($query) {
            $query->with('skill:id,name');
        }])->where('user_id', auth()->user()->id)->pending()->limit(4)->get();

        return Inertia::render('User/Dashboard', [
            'quizSchedules' => fractal($schedules, new QuizScheduleCardTransformer())->toArray()['data'],
            'practiceSessions' => fractal($practiceSessions, new PracticeSessionCardTransformer())->toArray()['data']
        ]);
    }

    /**
     * User's Practice Dashboard
     *
     * @return \Inertia\Response
     */
    public function practice()
    {
        return Inertia::render('User/PracticeDashboard', [
            'categories' => fractal(SubCategory::active()->has('sections')
                ->with(['sections:id,name,code,slug', 'subCategoryType:id,name', 'category:id,name'])
                ->orderBy('name')->get(), new SubCategoryCardTransformer())
                ->toArray()['data']
        ]);
    }

    /**
     * User's Quiz Dashboard
     *
     * @return \Inertia\Response
     */
    public function quiz()
    {
        $userGroups = auth()->user()->userGroups()->pluck('id');

        // Fetch quizzes scheduled for current user via user groups
        $schedules = QuizSchedule::whereHas('userGroups', function (Builder $query) use ($userGroups) {
            $query->whereIn('user_group_id', $userGroups);
        })->with(['quiz' => function($builder) {
            $builder->with(['subCategory:id,name', 'quizType:id,name']);
        }])->orderBy('end_date', 'asc')->active()->limit(4)->get();

        // Fetch public quizzes by quiz type
        $quizTypes = QuizType::select('id', 'code', 'slug', 'name')->whereHas('quizzes', function (Builder $query) {
            $query->isPublic()->published();
        })->with(['latestQuiz' => function($builder) {
            $builder->has('questions')->with(['subCategory:id,name', 'quizType:id,name'])->isPublic()->published();
        }])->active()->orderBy('name')->get();

//        return $quizTypes;

        return Inertia::render('User/QuizDashboard', [
            'quizSchedules' => fractal($schedules, new QuizScheduleCardTransformer())->toArray()['data'],
            'quizTypes' => fractal($quizTypes, new QuizTypeTransformer())->toArray()['data']
        ]);
    }

    /**
     * Live Quizzes Screen
     *
     * @return \Inertia\Response
     */
    public function liveQuizzes()
    {
        return Inertia::render('User/LiveQuizzes');
    }

    /**
     * Fetch live quizzes api endpoint
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function fetchLiveQuizzes()
    {
        $userGroups = auth()->user()->userGroups()->pluck('id');

        // Fetch quizzes scheduled for current user via user groups
        $schedules = QuizSchedule::whereHas('userGroups', function (Builder $query) use ($userGroups) {
            $query->whereIn('user_group_id', $userGroups);
        })->with(['quiz' => function($builder) {
            $builder->with(['subCategory:id,name', 'quizType:id,name']);
        }])->orderBy('end_date', 'asc')->active()->paginate(10);

        return response()->json([
            'schedules' => fractal($schedules, new QuizScheduleCardTransformer())->toArray()
        ], 200);
    }

    /**
     * Get Quizzes by type page
     *
     * @param QuizType $type
     * @return \Inertia\Response
     */
    public function quizzesByType(QuizType $type)
    {
        return Inertia::render('User/QuizzesByType', [
            'type' => $type,
        ]);
    }

    /**
     * Fetch quizzes by type
     *
     * @param QuizType $type
     * @return \Illuminate\Http\JsonResponse
     */
    public function fetchQuizzesByType(QuizType $type)
    {
        // Fetch public quizzes by quiz type
        $quizzes = $type->quizzes()->has('questions')
            ->with(['subCategory:id,name', 'quizType:id,name'])
            ->isPublic()->published()
            ->paginate(10);

        return response()->json([
            'quizzes' => fractal($quizzes, new QuizCardTransformer())->toArray()
        ], 200);
    }
}
