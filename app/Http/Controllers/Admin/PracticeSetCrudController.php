<?php
/**
 * File name: PracticeSetCrudController.php
 * Last modified: 19/07/21, 12:55 AM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Controllers\Admin;

use App\Filters\PracticeSetFilters;
use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\StorePracticeSetRequest;
use App\Http\Requests\Admin\UpdatePracticeSetRequest;
use App\Http\Requests\Admin\UpdatePracticeSetSettingsRequest;
use App\Models\PracticeSet;
use App\Models\Skill;
use App\Models\SubCategory;
use App\Repositories\PracticeSetRepository;
use App\Transformers\Admin\PracticeSetTransformer;
use App\Transformers\Admin\SkillSearchTransformer;
use App\Transformers\Admin\SubCategorySearchTransformer;
use Inertia\Inertia;

class PracticeSetCrudController extends Controller
{
    private PracticeSetRepository $repository;

    public function __construct(PracticeSetRepository $repository)
    {
        $this->middleware(['role:admin|instructor']);
        $this->repository = $repository;
    }

    /**
     * List all practice sets
     *
     * @param PracticeSetFilters $filters
     * @return \Inertia\Response
     */
    public function index(PracticeSetFilters $filters)
    {
        return Inertia::render('Admin/PracticeSets', [
            'practiceSets' => function () use($filters) {
                return fractal(PracticeSet::filter($filters)->with(['subCategory:id,name', 'skill:id,name'])
                    ->paginate(request()->perPage != null ? request()->perPage : 10),
                    new PracticeSetTransformer())->toArray();
            },
        ]);
    }

    /**
     * Create a practice set
     *
     * @return \Inertia\Response
     */
    public function create()
    {
        return Inertia::render('Admin/PracticeSet/Details', [
            'steps' => $this->repository->getSteps(),
            'initialSubCategories' => fractal(SubCategory::select(['id', 'name', 'category_id'])->latest()->take(10)->get(),
                new SubCategorySearchTransformer())->toArray()['data']
        ]);
    }

    /**
     * Store a practice set
     *
     * @param StorePracticeSetRequest $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function store(StorePracticeSetRequest $request)
    {
        $practiceSet = PracticeSet::create($request->validated());
        return redirect()->route('practice-sets.settings', ['practice_set' => $practiceSet->id])->with('successMessage', 'Details saved successfully!');
    }

    /**
     * Show a practice set
     *
     * @param $id
     * @return array
     */
    public function show($id)
    {
        $practiceSet = PracticeSet::find($id);
        return fractal($practiceSet, new PracticeSetTransformer())->toArray();
    }

    /**
     * Edit a practice set
     *
     * @param $id
     * @return \Inertia\Response
     */
    public function edit($id)
    {
        $set = PracticeSet::findOrfail($id);

        return Inertia::render('Admin/PracticeSet/Details', [
            'steps' => $this->repository->getSteps($set->id, 'details'),
            'editFlag' => true,
            'practiceSet' => $set,
            'practiceSetId' => $set->id,
            'initialSubCategories' => fractal(SubCategory::select(['id', 'name', 'category_id'])
                ->with('category:id,name')
                ->where('id', $set->sub_category_id)
                ->get(), new SubCategorySearchTransformer())
                ->toArray()['data'],
            'initialSkills' => fractal(Skill::select(['id', 'name', 'section_id'])
                ->with('section:id,name')
                ->where('id', $set->skill_id)
                ->get(), new SkillSearchTransformer())
                ->toArray()['data'],
        ]);
    }

    /**
     * Update a practice set
     *
     * @param UpdatePracticeSetRequest $request
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function update(UpdatePracticeSetRequest $request, $id)
    {
        $practiceSet = PracticeSet::find($id);
        $practiceSet->update($request->validated());
        return redirect()->route('practice-sets.settings', ['practice_set' => $practiceSet->id])->with('successMessage', 'Details saved successfully!');
    }

    /**
     * Practice set settings page
     *
     * @param $id
     * @return \Inertia\Response
     */
    public function settings($id)
    {
        $practiceSet = PracticeSet::findOrFail($id);
        return Inertia::render('Admin/PracticeSet/Settings', [
            'practiceSet' => $practiceSet,
            'steps' => $this->repository->getSteps($practiceSet->id, 'settings'),
            'editFlag' => true
        ]);
    }

    /**
     * Update practice set settings
     *
     * @param UpdatePracticeSetSettingsRequest $request
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function updateSettings(UpdatePracticeSetSettingsRequest $request, $id)
    {
        $practiceSet = PracticeSet::findOrFail($id);
        $practiceSet->update($request->validated());

        return redirect()->route('practice-sets.questions', ['practice_set' => $practiceSet->id])->with('successMessage', 'Practice Set Settings Successfully Updated.');
    }

    /**
     * Delete a practice set
     *
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroy($id)
    {
        try {
            $practiceSet = PracticeSet::find($id);

            $practiceSet->secureDelete('questions', 'sessions');
        }
        catch (\Illuminate\Database\QueryException $e){
            return redirect()->back()->with('errorMessage', 'Unable to Delete Practice Set . Remove all associations and Try again!');
        }
        return redirect()->back()->with('successMessage', 'Practice Set was successfully deleted!');
    }
}
