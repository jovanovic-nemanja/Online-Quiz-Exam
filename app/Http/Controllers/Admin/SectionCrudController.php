<?php
/**
 * File name: SectionCrudController.php
 * Last modified: 19/07/21, 12:55 AM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Section;
use App\Transformers\Admin\SectionSearchTransformer;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Filters\SectionFilters;
use App\Http\Requests\Admin\StoreSectionRequest;
use App\Http\Requests\Admin\UpdateSectionRequest;
use App\Transformers\Admin\SectionTransformer;

class SectionCrudController extends Controller
{
    public function __construct()
    {
        $this->middleware(['role:admin|instructor'])->except('search');
    }

    /**
     * List all sections
     *
     * @param SectionFilters $filters
     * @return \Inertia\Response
     */
    public function index(SectionFilters $filters)
    {
        return Inertia::render('Admin/Sections', [
            'sections' => function () use($filters) {
                return fractal(Section::filter($filters)
                    ->paginate(request()->perPage != null ? request()->perPage : 10),
                    new SectionTransformer())->toArray();
            },
        ]);
    }

    /**
     * Search sections api endpoint
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function search(Request $request)
    {
        $query = $request->get('query');
        return response()->json([
            'sections' => fractal(Section::select(['id', 'name'])
                ->where('name', 'like', '%'.$query.'%')->limit(20)
                ->get(), new SectionSearchTransformer())
                ->toArray()['data']
        ]);
    }

    /**
     * Store a section
     *
     * @param StoreSectionRequest $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function store(StoreSectionRequest $request)
    {
        Section::create($request->validated());
        return redirect()->back()->with('successMessage', 'Section was successfully added!');
    }

    /**
     * Show a section
     *
     * @param $id
     * @return array
     */
    public function show($id)
    {
        return fractal(Section::find($id), new SectionTransformer())->toArray();
    }

    /**
     * Edit a section
     *
     * @param $id
     * @return Section|Section[]|\Illuminate\Database\Eloquent\Collection|\Illuminate\Database\Eloquent\Model|null
     */
    public function edit($id)
    {
        return Section::find($id);
    }

    /**
     * Update a section
     *
     * @param UpdateSectionRequest $request
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function update(UpdateSectionRequest $request, $id)
    {
        $section = Section::find($id);
        $section->update($request->validated());
        return redirect()->back()->with('successMessage', 'Section was successfully updated!');
    }

    /**
     * Update a section
     *
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroy($id)
    {
        try {
            $section = Section::find($id);

            if(!$section->canSecureDelete('skills')) {
                return redirect()->back()->with('errorMessage', 'Unable to Delete Section . Remove all associations and Try again!');
            }

            $section->secureDelete('skills');
        }
        catch (\Illuminate\Database\QueryException $e){
            return redirect()->back()->with('errorMessage', 'Unable to Delete Section . Remove all associations and Try again!');
        }
        return redirect()->back()->with('successMessage', 'Section was successfully deleted!');
    }
}
