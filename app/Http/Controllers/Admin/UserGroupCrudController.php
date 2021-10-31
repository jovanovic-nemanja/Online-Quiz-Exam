<?php
/**
 * File name: UserGroupCrudController.php
 * Last modified: 19/07/21, 12:55 AM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Controllers\Admin;
use App\Filters\UserGroupFilters;
use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\StoreUserGroupRequest;
use App\Http\Requests\Admin\UpdateUserGroupRequest;
use App\Models\UserGroup;
use App\Transformers\Admin\UserGroupTransformer;
use Inertia\Inertia;

class UserGroupCrudController extends Controller
{
    public function __construct()
    {
        $this->middleware(['role:admin']);
    }

    /**
     * List all user groups
     *
     * @param UserGroupFilters $filters
     * @return \Inertia\Response
     */
    public function index(UserGroupFilters $filters)
    {
        return Inertia::render('Admin/UserGroups', [
                'userGroups' => function () use($filters) {
                    return fractal(UserGroup::filter($filters)
                        ->paginate(request()->perPage != null ? request()->perPage : 10),
                        new UserGroupTransformer())->toArray();
                },
            ]
        );
    }

    /**
     * Store an user group
     *
     * @param StoreUserGroupRequest $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function store(StoreUserGroupRequest $request)
    {
        UserGroup::create($request->validated());

        return redirect()->back()->with('successMessage', 'User Group was successfully added!');
    }

    /**
     * Show an user group
     *
     * @param $id
     * @return array
     */
    public function show($id)
    {
        $userGroup = UserGroup::find($id);

        return fractal($userGroup, new UserGroupTransformer())->toArray();
    }

    /**
     * Edit an user group
     *
     * @param $id
     * @return UserGroup|UserGroup[]|\Illuminate\Database\Eloquent\Collection|\Illuminate\Database\Eloquent\Model|null
     */
    public function edit($id)
    {
        return UserGroup::find($id);
    }

    /**
     * Update an user group
     *
     * @param UpdateUserGroupRequest $request
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function update(UpdateUserGroupRequest $request, $id)
    {
        $userGroup = UserGroup::find($id);

        $userGroup->update($request->validated());

        return redirect()->back()->with('successMessage', 'User Group was successfully updated!');
    }

    /**
     * Delete an user group
     *
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroy($id)
    {
        try {
            $userGroup = UserGroup::find($id);

            if(!$userGroup->canSecureDelete('users', 'quizSchedules')) {
                return redirect()->back()->with('errorMessage', 'Unable to Delete User Group. Remove all associations and Try again!');
            }

            $userGroup->secureDelete('users', 'quizSchedules');
        }
        catch (\Illuminate\Database\QueryException $e){
            return redirect()->back()->with('errorMessage','Unable to Delete User Group. Remove all associations and Try again!');
        }
        return redirect()->back()->with('successMessage','User Group Deleted successfully!');
    }
}
