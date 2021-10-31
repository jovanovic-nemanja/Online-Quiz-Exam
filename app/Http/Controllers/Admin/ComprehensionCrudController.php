<?php
/**
 * File name: ComprehensionCrudController.php
 * Last modified: 19/07/21, 12:55 AM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Controllers\Admin;

use App\Filters\ComprehensionFilters;
use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\StoreComprehensionRequest;
use App\Http\Requests\Admin\UpdateComprehensionRequest;
use App\Models\ComprehensionPassage;
use App\Transformers\Admin\ComprehensionTransformer;
use Illuminate\Http\Request;
use Inertia\Inertia;

class ComprehensionCrudController extends Controller
{
    public function __construct()
    {
        $this->middleware(['role:admin|instructor'])->except('search');
    }

    /**
     * List all comprehension passages
     *
     * @param ComprehensionFilters $filters
     * @return \Inertia\Response
     */
    public function index(ComprehensionFilters $filters)
    {
        return Inertia::render('Admin/Comprehensions', [
            'comprehensions' => function () use($filters) {
                return fractal(ComprehensionPassage::filter($filters)
                    ->paginate(request()->perPage != null ? request()->perPage : 10),
                    new ComprehensionTransformer())->toArray();
            },
        ]);
    }

    /**
     * Search comprehension  passages api endpoint
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function search(Request $request)
    {
        $query = $request->get('query');
        return response()->json([
            'comprehensions' => ComprehensionPassage::select(['id', 'title', 'code'])
                ->where('is_active', 1)
                ->where('title', 'like', '%'.$query.'%')
                ->orWhere('code', 'like', '%'.$query.'%')->limit(20)
                ->get()
        ]);
    }

    /**
     * Store a comprehension passage
     *
     * @param StoreComprehensionRequest $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function store(StoreComprehensionRequest $request)
    {
        ComprehensionPassage::create($request->validated());
        return redirect()->back()->with('successMessage', 'Comprehension Passage was successfully added!');
    }

    /**
     * Show a comprehension passage
     *
     * @param $id
     * @return array
     */
    public function show($id)
    {
        $comprehension = ComprehensionPassage::findOrFail($id);
        return fractal($comprehension, new ComprehensionTransformer())->toArray();
    }

    /**
     * Edit a comprehension passage
     *
     * @param $id
     * @return ComprehensionPassage|ComprehensionPassage[]|\Illuminate\Database\Eloquent\Collection|\Illuminate\Database\Eloquent\Model
     */
    public function edit($id)
    {
        return ComprehensionPassage::findOrFail($id);
    }

    /**
     * Update a comprehension passage
     *
     * @param UpdateComprehensionRequest $request
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function update(UpdateComprehensionRequest $request, $id)
    {
        $comprehension = ComprehensionPassage::findOrFail($id);
        $comprehension->update($request->validated());
        return redirect()->back()->with('successMessage', 'Comprehension Passage was successfully updated!');
    }

    /**
     * Delete a comprehension passage
     *
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroy($id)
    {
        try {
            $comprehension = ComprehensionPassage::findOrFail($id);

            if(!$comprehension->canSecureDelete('questions')) {
                return redirect()->back()->with('errorMessage', 'Unable to Delete Comprehension . Remove all associations and Try again!');
            }

            $comprehension->secureDelete('questions');
        }
        catch (\Illuminate\Database\QueryException $e){
            return redirect()->back()->with('errorMessage', 'Unable to Delete Comprehension Passage . Remove all associations and Try again!');
        }
        return redirect()->back()->with('successMessage', 'Comprehension Passage was successfully deleted!');
    }
}
