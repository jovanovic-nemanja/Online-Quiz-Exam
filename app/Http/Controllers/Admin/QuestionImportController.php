<?php
/**
 * File name: QuestionImportController.php
 * Last modified: 19/07/21, 12:55 AM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\ImportQuestionsRequest;
use App\Imports\QuestionsImport;
use App\Models\DifficultyLevel;
use App\Models\QuestionType;
use App\Models\Skill;
use Inertia\Inertia;

class QuestionImportController extends Controller
{
    public function __construct()
    {
        $this->middleware(['role:admin|instructor']);
    }

    /**
     * Import questions page
     *
     * @return \Inertia\Response
     */
    public function initiateImport()
    {
        return Inertia::render('Admin/ImportQuestions', [
            'questionTypes' => QuestionType::select(['id', 'code', 'name'])->active()->get(),
            'difficultyLevels' => DifficultyLevel::select(['id', 'code', 'name'])->active()->get(),
            'sampleFileUrl' => url('assets/sample.xlsx')
        ]);
    }

    /**
     * Import questions from excel sheet
     *
     * @param ImportQuestionsRequest $request
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function import(ImportQuestionsRequest $request, $id)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! Files can\'t be imported.');
        }

        $file = $request->file('file')->store('imports');
        $skill = Skill::select(['id','name'])->findOrFail($id);

        $questionTypes = QuestionType::pluck('id', 'code');
        $difficultyLevels = DifficultyLevel::pluck('id', 'code');

        try {
            $import = new QuestionsImport($questionTypes, $difficultyLevels, $skill->id);
            $import->import($file);
        } catch (\Exception $exception) {
            return redirect()->back()->with('errorMessage', 'Oops! Upload Failed. Please check all rows are entered accurately.');
        }

        return redirect()->route('questions.index')
            ->with('successMessage', $import->getRowCount().' Questions were imported successfully.');
    }
}
