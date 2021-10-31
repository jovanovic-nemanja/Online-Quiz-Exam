<?php
/**
 * File name: PracticeSetQuestionController.php
 * Last modified: 19/07/21, 12:55 AM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Controllers\Admin;

use App\Filters\QuestionFilters;
use App\Http\Controllers\Controller;
use App\Models\DifficultyLevel;
use App\Models\PracticeSet;
use App\Models\Question;
use App\Models\QuestionType;
use App\Repositories\PracticeSetRepository;
use App\Transformers\Admin\QuestionPreviewTransformer;
use Inertia\Inertia;

class PracticeSetQuestionController extends Controller
{
    private PracticeSetRepository $repository;

    public function __construct(PracticeSetRepository $repository)
    {
        $this->middleware(['role:admin|instructor']);
        $this->repository = $repository;
    }

    /**
     * Practice set questions page
     *
     * @param $id
     * @return \Inertia\Response
     */
    public function index($id)
    {
        $test = PracticeSet::select(['id', 'title'])->findOrFail($id);

        return Inertia::render('Admin/PracticeSet/Questions', [
            'practiceSet' => $test->only(['id', 'title']),
            'steps' => $this->repository->getSteps($test->id, 'questions'),
            'editFlag' => true,
            'difficultyLevels' => DifficultyLevel::select(['id', 'name'])->active()->get(),
            'questionTypes' => QuestionType::select(['id', 'name'])->active()->get()
        ]);
    }

    /**
     * Fetch practice set questions api endpoint
     *
     * @param $id
     * @param QuestionFilters $filters
     * @return \Illuminate\Http\JsonResponse
     */
    public function fetchQuestions($id, QuestionFilters $filters)
    {
        $set = PracticeSet::select(['id', 'title'])->findOrFail($id);

        $questions = $set->questions()->with(['questionType:id,name,code', 'difficultyLevel:id,name,code', 'skill:id,name'])
            ->filter($filters)
            ->paginate(10);

        return response()->json([
            'questions' => fractal($questions, new QuestionPreviewTransformer())->toArray()
        ], 200);
    }

    /**
     * Fetch available questions api endpoint
     *
     * @param $id
     * @param QuestionFilters $filters
     * @return \Illuminate\Http\JsonResponse
     */
    public function fetchAvailableQuestions($id, QuestionFilters $filters)
    {
        $set = PracticeSet::select(['id', 'title', 'skill_id'])->with(['questions' => function($builder) {
            $builder->select('id');
        }])->findOrFail($id);

        $questions = Question::filter($filters)->whereNotIn('id', $set->questions->pluck('id'))
            ->with(['questionType:id,name,code', 'difficultyLevel:id,name,code', 'skill:id,name'])
            ->where('skill_id', $set->skill_id)->paginate(10);

        return response()->json([
            'questions' => fractal($questions, new QuestionPreviewTransformer())->toArray()
        ], 200);
    }

    /**
     * Add a question to practice set
     *
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function addQuestion($id)
    {
        try {
            $question = Question::with('questionType:id,type')->findOrFail(request()->get('question_id'));
            $set = PracticeSet::select(['id', 'title'])->findOrFail($id);

            if($question->questionType->type == 'subjective') {
                return response()->json([
                    'status' => 'warning',
                    'message' => 'Can\'t add subjective type questions to practice set.'
                ], 200);
            }

            if (!$set->questions->contains($question->id)) {
                $set->questions()->attach($question->id, ['practice_set_id' => $set->id]);
                $set->total_questions = $set->questions()->count();

                $set->update();
            }
            return response()->json(['status' => 'success', 'message' => 'Question Added Successfully'], 200);

        } catch (\Exception $e) {
            return response()->json(['status' => 'error', 'message' => 'Something Went Wrong']);
        }
    }

    /**
     * Remove a question from practice set
     *
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function removeQuestion($id)
    {
        try {
            $question = Question::with('questionType:id,type')->findOrFail(request()->get('question_id'));
            $set = PracticeSet::select(['id', 'title'])->findOrFail($id);

            $set->questions()->detach($question->id);
            $set->total_questions = $set->questions()->count();
            $set->update();

            return response()->json(['status' => 'success', 'message' => 'Question Removed Successfully'], 200);

        } catch (\Exception $e) {
            return response()->json(['status' => 'error', 'message' => 'Something Went Wrong']);
        }
    }
}
