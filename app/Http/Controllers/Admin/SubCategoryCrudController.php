<?php
/**
 * File name: SubCategoryCrudController.php
 * Last modified: 19/07/21, 12:55 AM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Filters\SubCategoryFilters;
use App\Http\Requests\Admin\StoreSubCategoryRequest;
use App\Http\Requests\Admin\UpdateSubCategoryRequest;
use App\Models\Category;
use App\Models\Section;
use App\Models\SubCategory;
use App\Models\SubCategoryType;
use App\Transformers\Admin\SubCategorySearchTransformer;
use App\Transformers\Admin\SubCategoryTransformer;
use Illuminate\Http\Request;
use Inertia\Inertia;

class SubCategoryCrudController extends Controller
{
    public function __construct()
    {
        $this->middleware(['role:admin'])->except('search');
    }

    /**
     * List all subcategories
     *
     * @param SubCategoryFilters $filters
     * @return \Inertia\Response
     */
    public function index(SubCategoryFilters $filters)
    {
        return Inertia::render('Admin/SubCategories', [
            'categories' => Category::select(['name', 'id'])->get(),
            'types' => SubCategoryType::select(['name', 'id'])->get(),
            'subCategories' => function () use($filters) {
                return fractal(SubCategory::filter($filters)->with('category:id,name')
                    ->with('subCategoryType:id,name')
                    ->paginate(request()->perPage != null ? request()->perPage : 10),
                    new SubCategoryTransformer())->toArray();
            },
        ]);
    }

    /**
     * Search subcategories api endpoint
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function search(Request $request)
    {
        $query = $request->get('query');
        return response()->json([
            'subCategories' => fractal(SubCategory::select(['id', 'name', 'category_id'])
                ->with('category:id,name')
                ->where('name', 'like', '%'.$query.'%')
                ->orWhere('code', 'like', '%'.$query.'%')
                ->limit(20)
                ->get(), new SubCategorySearchTransformer())
                ->toArray()['data']
        ]);
    }

    /**
     * Store a section
     *
     * @param StoreSubCategoryRequest $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function store(StoreSubCategoryRequest $request)
    {
        SubCategory::create($request->validated());
        return redirect()->route('sub-categories.index')
            ->with('successMessage', 'Sub Category was successfully added!');
    }

    /**
     * Show a section
     *
     * @param $id
     * @return array
     */
    public function show($id)
    {
        $subCategory = SubCategory::find($id);
        return fractal($subCategory, new SubCategoryTransformer())->toArray();
    }

    /**
     * Edit a section
     *
     * @param $id
     * @return SubCategory|SubCategory[]|\Illuminate\Database\Eloquent\Collection|\Illuminate\Database\Eloquent\Model|null
     */
    public function edit($id)
    {
        return SubCategory::find($id);
    }

    /**
     * Update a section
     *
     * @param UpdateSubCategoryRequest $request
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function update(UpdateSubCategoryRequest $request, $id)
    {
        $subCategory = SubCategory::find($id);
        $subCategory->update($request->validated());
        return redirect()->route('sub-categories.index')
            ->with('successMessage', 'Sub Category was successfully updated!');
    }

    /**
     * Fetch sections api endpoint for mapping
     *
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function fetchSections($id)
    {
        $subCategory = SubCategory::findOrFail($id);

        return response()->json([
            'sections' => Section::active()->get(['id', 'name']),
            'selected_sections' => $subCategory->sections()->pluck('id')
        ], 200);
    }

    /**
     * Update subcategory sections
     *
     * @param Request $request
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function updateSections(Request $request, $id)
    {
        $subCategory = SubCategory::findOrFail($id);
        $subCategory->sections()->sync($request->selected_sections);
        return redirect()->back()->with('successMessage', 'Sections successfully updated!');
    }

    /**
     * Delete a section
     *
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroy($id)
    {
        try {
            $subCategory = SubCategory::find($id);

            if(!$subCategory->canSecureDelete('practiceSets', 'quizzes')) {
                return redirect()->back()->with('errorMessage', 'Unable to Delete Sub Category . Remove all associations and Try again!');
            }

            $subCategory->sections()->detach();

            $subCategory->secureDelete('practiceSets', 'quizzes');
        }
        catch (\Illuminate\Database\QueryException $e){
            return redirect()->route('sub-categories.index')
                ->with('errorMessage', 'Unable to Delete Sub Category . Remove all associations and Try again!');
        }
        return redirect()->route('sub-categories.index')
            ->with('successMessage', 'Sub Category was successfully deleted!');
    }
}
