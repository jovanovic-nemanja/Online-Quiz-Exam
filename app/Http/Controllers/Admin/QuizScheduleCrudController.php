<?php
/**
 * File name: QuizScheduleCrudController.php
 * Last modified: 19/07/21, 12:55 AM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Controllers\Admin;

use App\Filters\QuizScheduleFilters;
use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\StoreQuizScheduleRequest;
use App\Http\Requests\Admin\UpdateQuizScheduleRequest;
use App\Models\Quiz;
use App\Models\QuizSchedule;
use App\Models\UserGroup;
use App\Repositories\QuizRepository;
use App\Settings\LocalizationSettings;
use App\Transformers\Admin\QuizScheduleTransformer;
use Carbon\Carbon;
use Inertia\Inertia;

class QuizScheduleCrudController extends Controller
{
    private QuizRepository $repository;

    public function __construct(QuizRepository $repository)
    {
        $this->middleware(['role:admin|instructor']);
        $this->repository = $repository;
    }

    /**
     * List all quiz schedules of a quiz
     *
     * @param $id
     * @param QuizScheduleFilters $filters
     * @return \Illuminate\Http\RedirectResponse|\Inertia\Response
     */
    public function index($id, QuizScheduleFilters $filters)
    {
        $quiz = Quiz::findOrFail($id);

        if(!$quiz->is_active) {
            return redirect()->back()->with('errorMessage', 'Quiz is in draft mode. Kindly publish quiz before scheduling it to users');
        }

        return Inertia::render('Admin/QuizSchedules', [
            'quiz' => $quiz->only(['id', 'title']),
            'steps' => $this->repository->getSteps($quiz->id, 'schedules'),
            'editFlag' => true,
            'quizSchedules' => function () use($filters, $quiz) {
                return fractal(QuizSchedule::filter($filters)
                    ->with('quiz:id,title')
                    ->where('quiz_id', $quiz->id)
                    ->paginate(request()->perPage != null ? request()->perPage : 10),
                    new QuizScheduleTransformer())->toArray();
            },
            'userGroups' => UserGroup::select(['id', 'name'])->active()->get()
        ]);
    }

    /**
     * Store a quiz schedule
     *
     * @param StoreQuizScheduleRequest $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function store(StoreQuizScheduleRequest $request)
    {
        $quiz = Quiz::findOrFail($request->quiz_id);
        $schedule = new QuizSchedule();

        if($request->schedule_type == 'fixed') {
            $startDate = Carbon::createFromFormat('Y-m-d H:i:s', $request->start_date.' '.$request->start_time);
            $schedule->start_date = $startDate->toDateString();
            $schedule->start_time = $startDate->toTimeString();

            $endDate = $startDate->addSeconds($quiz->total_duration);
            $schedule->end_date = $endDate->toDateString();
            $schedule->end_time = $endDate->toTimeString();

            $schedule->grace_period = $request->grace_period;
        }

        if($request->schedule_type == 'flexible') {
            $startDate = Carbon::createFromFormat('Y-m-d H:i:s', $request->start_date.' '.$request->start_time);
            $schedule->start_date = $startDate->toDateString();
            $schedule->start_time = $startDate->toTimeString();

            $endDate = Carbon::createFromFormat('Y-m-d H:i:s', $request->end_date.' '.$request->end_time);
            $schedule->end_date = $endDate->toDateString();
            $schedule->end_time = $endDate->toTimeString();
        }

        $schedule->quiz_id = $request->quiz_id;
        $schedule->schedule_type = $request->schedule_type;
        $schedule->status = $request->status;
        $schedule->save();

        if($schedule) {
            $schedule->userGroups()->sync($request->user_groups);
        }

        return redirect()->back()->with('successMessage', 'Quiz Schedule was successfully added!');
    }

    /**
     * Show a quiz schedule
     *
     * @param $id
     * @return array
     */
    public function show($id)
    {
        $quizSchedule = QuizSchedule::find($id);
        return fractal($quizSchedule, new QuizScheduleTransformer())->toArray();
    }

    /**
     * Edit a quiz schedule
     *
     * @param Quiz $quiz
     * @param $id
     * @param LocalizationSettings $localization
     * @return \Illuminate\Http\JsonResponse
     */
    public function edit(Quiz $quiz, $id, LocalizationSettings $localization)
    {
        $schedule = QuizSchedule::with(['userGroups:id'])->find($id);
        $now = Carbon::now()->timezone($localization->default_timezone);
        $startsIn =  $now->diffInSeconds($schedule->starts_at, false);
        return response()->json([
            'schedule' => $schedule,
            'userGroups' => $schedule->userGroups()->pluck('id'),
            'disableFlag' => $schedule->status == 'expired' || $startsIn < 15
        ]);
    }

    /**
     * Update a quiz schedule
     *
     * @param UpdateQuizScheduleRequest $request
     * @param Quiz $quiz
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function update(UpdateQuizScheduleRequest $request, Quiz $quiz, $id)
    {
        $schedule = QuizSchedule::with('quiz:id,total_duration')->find($id);

        if($schedule->status == 'expired') {
            return redirect()->back()->with('errorMessage', 'You can\'t update once quiz schedule starts or expired. Please create a new schedule.');
        }

        if($schedule->schedule_type == 'fixed') {
            $startDate = Carbon::createFromFormat('Y-m-d H:i:s', $request->start_date.' '.$request->start_time);
            $schedule->start_date = $startDate->toDateString();
            $schedule->start_time = $startDate->toTimeString();

            $endDate = $startDate->addSeconds($schedule->quiz->total_duration);
            $schedule->end_date = $endDate->toDateString();
            $schedule->end_time = $endDate->toTimeString();

            $schedule->grace_period = $request->grace_period;
        }

        if($schedule->schedule_type == 'flexible') {
            $startDate = Carbon::createFromFormat('Y-m-d H:i:s', $request->start_date.' '.$request->start_time);
            $schedule->start_date = $startDate->toDateString();
            $schedule->start_time = $startDate->toTimeString();

            $endDate = Carbon::createFromFormat('Y-m-d H:i:s', $request->end_date.' '.$request->end_time);
            $schedule->end_date = $endDate->toDateString();
            $schedule->end_time = $endDate->toTimeString();
        }

        $schedule->status = $request->status;
        $schedule->update();

        if($schedule) {
            $schedule->userGroups()->sync($request->user_groups);
        }

        return redirect()->back()->with('successMessage', 'Quiz Schedule was successfully updated!');
    }

    /**
     * Delete a quiz schedule
     * 
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroy($id)
    {
        try {
            $quizSchedule = QuizSchedule::find($id);
            $quizSchedule->userGroups()->detach();
            $quizSchedule->secureDelete('sessions');
        }
        catch (\Illuminate\Database\QueryException $e){
            return redirect()->back()->with('errorMessage', 'Unable to Delete Quiz Schedule . Remove all associations and Try again!');
        }
        return redirect()->back()->with('successMessage', 'Quiz Schedule was successfully deleted!');
    }
}
