<?php
/**
 * File name: QuizQuestionController.php
 * Last modified: 19/07/21, 12:55 AM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Controllers\Admin;

use App\Filters\QuestionFilters;
use App\Http\Controllers\Controller;
use App\Models\DifficultyLevel;
use App\Models\QuestionType;
use App\Models\Quiz;
use App\Models\Question;
use App\Repositories\QuizRepository;
use App\Transformers\Admin\QuestionPreviewTransformer;
use Inertia\Inertia;

class QuizQuestionController extends Controller
{
    private $repository;

    public function __construct(QuizRepository $repository)
    {
        $this->middleware(['role:admin|instructor']);
        $this->repository = $repository;
    }
    
    /**
     * Quiz questions page
     *
     * @param $id
     * @return \Inertia\Response
     */
    public function index($id)
    {
        $quiz = Quiz::select(['id', 'title','quiz_type_id'])->findOrFail($id);

        return Inertia::render('Admin/Quiz/Questions', [
            'quiz' => $quiz->only(['id', 'title','quiz_type_id']),
            'steps' => $this->repository->getSteps($quiz->id, 'questions'),
            'editFlag' => true,
            'difficultyLevels' => DifficultyLevel::select(['id', 'name'])->active()->get(),
            'questionTypes' => QuestionType::select(['id', 'name'])->active()->get()
        ]);
    }

    /**
     * Fetch quiz questions api endpoint
     * @param $id
     * @param QuestionFilters $filters
     * @return \Illuminate\Http\JsonResponse
     */
    public function fetchQuestions($id, QuestionFilters $filters)
    {
        $quiz = Quiz::select(['id', 'title','quiz_type_id'])->findOrFail($id);

        $type = $quiz->quizType;
        $questions = [];

        if($type->name === 'Personality') {
            $questions = $quiz->questions()->filter($filters)
            ->with(['questionType:id,name,code', 'difficultyLevel:id,name,code', 'skill:id,name'])
            ->where('question_type_id',9)
            ->paginate(10);
        } else {
            $questions = $quiz->questions()->filter($filters)
            ->with(['questionType:id,name,code', 'difficultyLevel:id,name,code', 'skill:id,name'])
            ->where('question_type_id','!=',9)
            ->paginate(10);
        }

        

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
        $quiz = Quiz::select(['id', 'title','quiz_type_id'])->with(['questions' => function ($builder) {
            $builder->select('id');
        }])->findOrFail($id);

        $questions = Question::filter($filters)->whereNotIn('id', $quiz->questions->pluck('id'))
            ->with(['questionType:id,name,code', 'difficultyLevel:id,name,code', 'skill:id,name'])
            ->paginate(10);


        $type = $quiz->quizType;
        $questions = [];

        if($type->name === 'Personality') {
            $questions = Question::filter($filters)->whereNotIn('id', $quiz->questions->pluck('id'))
            ->where('question_type_id',9)
            ->with(['questionType:id,name,code', 'difficultyLevel:id,name,code', 'skill:id,name'])
            ->paginate(10);
        } else {
            $questions = Question::filter($filters)->whereNotIn('id', $quiz->questions->pluck('id'))
            ->where('question_type_id','!=',9)
            ->with(['questionType:id,name,code', 'difficultyLevel:id,name,code', 'skill:id,name'])
            ->paginate(10);
        }

        return response()->json([
            'questions' => fractal($questions, new QuestionPreviewTransformer())->toArray()
        ], 200);
    }

    /**
     * Add a question to quiz
     *
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function addQuestion($id)
    {
        try {
            $question = Question::with('questionType:id,type')->findOrFail(request()->get('question_id'));
            $quiz = Quiz::select(['id', 'title','quiz_type_id', 'settings'])->findOrFail($id);

            if ($question->questionType->type == 'subjective') {
                return response()->json([
                    'status' => 'warning',
                    'message' => 'Can\'t add subjective type questions to practice set.'
                ], 200);
            }

            if (!$quiz->questions->contains($question->id)) {
                $quiz->questions()->attach($question->id, ['quiz_id' => $quiz->id]);
            }

            $quiz->updateMeta();

            return response()->json(['status' => 'success', 'message' => 'Question Added Successfully'], 200);

        } catch (\Exception $e) {
            return response()->json(['status' => 'error', 'message' => 'Something Went Wrong']);
        }
    }

    /**
     * Remove a question from quiz
     *
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function removeQuestion($id)
    {
        try {
            $question = Question::with('questionType:id,type')->findOrFail(request()->get('question_id'));
            $quiz = Quiz::select(['id', 'title','quiz_type_id', 'settings'])->findOrFail($id);

            $quiz->questions()->detach($question->id);

            $quiz->updateMeta();

            return response()->json(['status' => 'success', 'message' => 'Question Removed Successfully'], 200);

        } catch (\Exception $e) {
            return response()->json(['status' => 'error', 'message' => 'Something Went Wrong']);
        }
    }
}
