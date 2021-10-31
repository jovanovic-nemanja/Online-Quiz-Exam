<?php
/**
 * File name: QuestionCrudController.php
 * Last modified: 19/07/21, 12:55 AM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Controllers\Admin;

use App\Filters\QuestionFilters;
use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\QuestionAttachmentRequest;
use App\Http\Requests\Admin\QuestionSettingsRequest;
use App\Http\Requests\Admin\QuestionSolutionRequest;
use App\Http\Requests\Admin\StoreQuestionRequest;
use App\Http\Requests\Admin\UpdateQuestionRequest;
use App\Models\ComprehensionPassage;
use App\Models\DifficultyLevel;
use App\Models\Question;
use App\Models\QuestionType;
use App\Models\Skill;
use App\Models\Topic;
use App\Repositories\QuestionRepository;
use App\Transformers\Admin\QuestionTransformer;
use App\Transformers\Admin\SkillSearchTransformer;
use App\Transformers\Admin\TopicSearchTransformer;
use Inertia\Inertia;

class QuestionCrudController extends Controller
{
    private QuestionRepository $repository;

    public function __construct(QuestionRepository $repository)
    {
        $this->middleware(['role:admin|instructor']);
        $this->repository = $repository;
    }

    /**
     * List all questions
     *
     * @param QuestionFilters $filters
     * @return \Inertia\Response
     */
    public function index(QuestionFilters $filters)
    {
        return Inertia::render('Admin/Questions', [
            'questionTypes' => QuestionType::select(['id as value', 'code', 'name as text'])->active()->get(),
            'questions' => function () use($filters) {
                return fractal(Question::filter($filters)
                    ->with(['questionType:id,name,code', 'section:sections.id,sections.name', 'skill:id,name', 'topic:id,name'])
                    ->orderBy('id', 'desc')
                    ->paginate(request()->perPage != null ? request()->perPage : 10),
                    new QuestionTransformer())->toArray();
            },
        ]);
    }

    /**
     * Create a question
     *
     * @return \Inertia\Response
     */
    public function create()
    {
        // Select MSA as default question type if no question type specified
        if(request()->has('question_type')) {
            $questionType = QuestionType::select(['id', 'code', 'name'])
                ->where('code', request()->get('question_type'))
                ->firstOrFail();
        } else {
            $questionType = QuestionType::select(['id', 'code', 'name'])->first();
        }

        return Inertia::render('Admin/Question/Details', [
            'steps' => $this->repository->getSteps(),
            'questionType' => $questionType,
            'initialOptions' => $this->repository->setDefaultOptions($questionType->code),
            'initialAnswers' => $this->repository->setDefaultAnswers($questionType->code),
            'initialPreferences' => $this->repository->setDefaultPreferences($questionType->code)
        ]);
    }

    /**
     * Store a question
     *
     * @param StoreQuestionRequest $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function store(StoreQuestionRequest $request)
    {
        $question = new Question();
        $question->question = $request->question;
        $question->question_type_id = $request->question_type_id;
        $question->options = $request->options;
        $question->correct_answer = $request->question_type_id == 7 ? getBlankItems($request->question) :  $request->correct_answer;
        $question->skill_id = $request->skill_id;
        $question->preferences = $request->preferences;
        $question->save();

        return redirect()->route('question_settings', ['id' => $question->id])->with('successMessage', 'Details saved successfully!');
    }

    /**
     * Show a question
     *
     * @param $id
     * @return array
     */
    public function show($id)
    {
        $question= Question::find($id);
        return fractal($question, new QuestionTransformer())->toArray();
    }

    /**
     * Edit a question
     *
     * @param $id
     * @return \Inertia\Response
     */
    public function edit($id)
    {
        $question = Question::findOrFail($id);
        return Inertia::render('Admin/Question/Details', [
            'steps' => $this->repository->getSteps($question->id, 'details'),
            'questionType' => QuestionType::select(['id', 'code', 'name'])->find($question->question_type_id),
            'question' => $question,
            'editFlag' => true,
            'questionId' => $question->id,
        ]);
    }

    /**
     * Update a question
     *
     * @param UpdateQuestionRequest $request
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function update(UpdateQuestionRequest $request, $id)
    {
        $question = Question::findOrFail($id);
        $question->question = $request->question;
        $question->question_type_id = $request->question_type_id;
        $question->options = $request->options;
        $question->correct_answer = $request->question_type_id == 7 ? getBlankItems($request->question) :  $request->correct_answer;
        $question->preferences = $request->preferences;
        $question->update();

        return redirect()->route('question_settings', ['id' => $question->id])->with('successMessage', 'Details saved successfully!');
    }

    /**
     * Question settings page
     *
     * @param $id
     * @return \Inertia\Response
     */
    public function settings($id)
    {
        $question = Question::findOrFail($id);
        return Inertia::render('Admin/Question/Settings', [
            'steps' => $this->repository->getSteps($question->id, 'settings'),
            'question' => $question,
            'questionType' => QuestionType::select(['id', 'code', 'name'])->find($question->question_type_id),
            'editFlag' => true,
            'questionId' => $question->id,
            'difficultyLevels' => DifficultyLevel::select(['name', 'id'])->get(),
            'initialSkills' => fractal(Skill::select(['id', 'name', 'section_id'])
                ->with('section:id,name')
                ->where('id', $question->skill_id)
                ->get(), new SkillSearchTransformer())
                ->toArray()['data'],
            'initialTopics' => fractal(Topic::select(['id', 'name', 'skill_id'])
                ->with('skill:id,name')
                ->where('skill_id', $question->skill_id)
                ->get(), new TopicSearchTransformer())
                ->toArray()['data'],
        ]);
    }

    /**
     * Update question settings
     *
     * @param QuestionSettingsRequest $request
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function updateSettings(QuestionSettingsRequest $request, $id)
    {
        $question = Question::findOrFail($id);
        $question->skill_id = $request->skill_id;
        $question->topic_id = $request->topic_id;
        $question->difficulty_level_id = $request->difficulty_level_id;
        $question->default_marks = $request->default_marks;
        $question->default_time = $request->default_time;
        $question->update();

        return redirect()->route('question_solution', ['id' => $question->id])->with('successMessage', 'Settings saved successfully!');
    }

    /**
     * Question solution page
     *
     * @param $id
     * @return \Inertia\Response
     */
    public function solution($id)
    {
        $question = Question::findOrFail($id);
        return Inertia::render('Admin/Question/Solution', [
            'steps' => $this->repository->getSteps($question->id, 'solution'),
            'questionType' => QuestionType::select(['id', 'code', 'name'])->find($question->question_type_id),
            'question' => $question,
            'editFlag' => true,
            'questionId' => $question->id,
        ]);
    }

    /**
     * Update question solution
     *
     * @param QuestionSolutionRequest $request
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function updateSolution(QuestionSolutionRequest $request, $id)
    {
        $question = Question::findOrFail($id);
        $question->hint = $request->hint;
        $question->solution = $request->solution;
        $question->update();

        return redirect()->route('question_attachment', ['id' => $question->id])->with('successMessage', 'Solution updated successfully!');
    }

    /**
     * Question attachment page
     *
     * @param $id
     * @return \Inertia\Response
     */
    public function attachment($id)
    {
        $question = Question::findOrFail($id);
        return Inertia::render('Admin/Question/Attachment', [
            'steps' => $this->repository->getSteps($question->id, 'attachment'),
            'questionType' => QuestionType::select(['id', 'code', 'name'])->find($question->question_type_id),
            'question' => $question,
            'editFlag' => true,
            'questionId' => $question->id,
            'initialComprehensions' => ComprehensionPassage::where('id', $question->comprehension_passage_id)->get()
        ]);
    }

    /**
     * Update question attachment
     *
     * @param QuestionAttachmentRequest $request
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function updateAttachment(QuestionAttachmentRequest $request, $id)
    {
        $question = Question::findOrFail($id);
        $question->has_attachment = $request->has_attachment;
        $question->attachment_type = $request->attachment_type;
        $question->comprehension_passage_id = $request->attachment_type == 'comprehension' ? $request->comprehension_id : null;
        $question->attachment_options = $request->attachment_type == 'comprehension' ? null : $request->attachment_options;
        $question->update();

        return redirect()->route('questions.index')->with('successMessage', 'Attachment successfully updated!');
    }

    /**
     * Delete a question
     *
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroy($id)
    {
        try {
            $question = Question::find($id);

            if(!$question->canSecureDelete('quizzes', 'practiceSets')) {
                return redirect()->back()->with('errorMessage', 'Unable to Delete Question . Remove all associations and Try again!');
            }

            $question->secureDelete('quizzes', 'practiceSets', 'practiceSessions', 'quizSessions');
        }
        catch (\Illuminate\Database\QueryException $e){
            return redirect()->back()->with('errorMessage', 'Unable to Delete Question . Remove all associations and Try again!');
        }
        return redirect()->back()->with('successMessage', 'Question was successfully deleted!');
    }
}
