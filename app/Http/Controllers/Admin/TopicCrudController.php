<?php
/**
 * File name: TopicCrudController.php
 * Last modified: 19/07/21, 12:55 AM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Skill;
use App\Models\Topic;
use App\Transformers\Admin\TopicSearchTransformer;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Filters\TopicFilters;
use App\Http\Requests\Admin\StoreTopicRequest;
use App\Http\Requests\Admin\UpdateTopicRequest;
use App\Transformers\Admin\TopicTransformer;

class TopicCrudController extends Controller
{
    public function __construct()
    {
        $this->middleware(['role:admin|instructor'])->except('search');
    }

    /**
     * List all topics
     *
     * @param TopicFilters $filters
     * @return \Inertia\Response
     */
    public function index(TopicFilters $filters)
    {
        return Inertia::render('Admin/Topics', [
            'skills' => Skill::select(['name', 'id'])->get(),
            'topics' => function () use($filters) {
                return fractal(Topic::filter($filters)
                    ->paginate(request()->perPage != null ? request()->perPage : 10),
                    new TopicTransformer())->toArray();
            },
        ]);
    }

    /**
     * Search topics api endpoint
     *
     * @param Request $request
     * @param TopicFilters $filters
     * @return \Illuminate\Http\JsonResponse
     */
    public function search(Request $request, TopicFilters $filters)
    {
        $query = $request->get('query');
        return response()->json([
            'topics' => fractal(Topic::select(['id', 'name', 'skill_id'])
                ->filter($filters)
                ->with('skill:id,name')
                ->where('name', 'like', '%'.$query.'%')->limit(20)
                ->get(), new TopicSearchTransformer())
                ->toArray()['data']
        ]);
    }

    /**
     * Store a topic
     *
     * @param StoreTopicRequest $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function store(StoreTopicRequest $request)
    {
        Topic::create($request->validated());
        return redirect()->back()->with('successMessage', 'Topic was successfully added!');
    }

    /**
     * Show a topic
     *
     * @param $id
     * @return array
     */
    public function show($id)
    {
        $topic = Topic::find($id);
        return fractal($topic, new TopicTransformer())->toArray();
    }

    /**
     * Edit a topic
     *
     * @param $id
     * @return Topic|Topic[]|\Illuminate\Database\Eloquent\Collection|\Illuminate\Database\Eloquent\Model|null
     */
    public function edit($id)
    {
        return Topic::find($id);
    }

    /**
     * Update a topic
     *
     * @param UpdateTopicRequest $request
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function update(UpdateTopicRequest $request, $id)
    {
        $topic = Topic::find($id);
        $topic->update($request->validated());
        return redirect()->back()->with('successMessage', 'Topic was successfully updated!');
    }

    /**
     * Delete a topic
     *
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroy($id)
    {
        try {
            $topic = Topic::find($id);

            if(!$topic->canSecureDelete('questions')) {
                return redirect()->back()->with('errorMessage', 'Unable to Delete Topic. Remove all associations and Try again!');
            }

            $topic->secureDelete('questions');
        }
        catch (\Illuminate\Database\QueryException $e){
            return redirect()->back()->with('errorMessage', 'Unable to Delete Topic . Remove all associations and Try again!');
        }
        return redirect()->back()->with('successMessage', 'Topic was successfully deleted!');
    }
}
