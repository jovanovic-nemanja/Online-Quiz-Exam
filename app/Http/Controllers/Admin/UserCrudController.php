<?php
/**
 * File name: UserCrudController.php
 * Last modified: 19/07/21, 12:55 AM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Filters\UserFilters;
use App\Http\Requests\Admin\StoreUserRequest;
use App\Http\Requests\Admin\UpdateUserRequest;
use App\Models\User;
use App\Models\UserGroup;
use App\Transformers\Admin\UserTransformer;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Inertia\Inertia;

class UserCrudController extends Controller
{
    public function __construct()
    {
        $this->middleware(['role:admin']);
    }

    /**
     * List all users
     *
     * @param UserFilters $filters
     * @return \Inertia\Response
     */
    public function index(UserFilters $filters)
    {
        return Inertia::render('Admin/Users', [
            'roles' => [
                ['value' => 1, 'text' => 'Admin'],
                ['value' => 2, 'text' => 'Instructor'],
                ['value' => 3, 'text' => 'Student'],
                ['value' => 5, 'text' => 'Guest'],
            ],
            'users' => function () use($filters) {
                return fractal(User::with('roles:id,name')->filter($filters)
                ->paginate(request()->perPage != null ? request()->perPage : 10),
		               new UserTransformer())->toArray();
		          },
            'userGroups' => UserGroup::select(['id', 'name'])->active()->get()
        ]);
    }

    /**
     * Store an user
     *
     * @param StoreUserRequest $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function store(StoreUserRequest $request)
    {
        $user = User::create([
            'first_name' => $request['first_name'],
            'last_name' => $request['last_name'],
            'user_name' => $request['user_name'],
            'email' => $request['email'],
            'password' => Hash::make($request['password']),
            'is_active' => $request['is_active'],
        ]);

        if($user) {
            $user->assignRole($request['role']);
            $user->userGroups()->sync($request->user_groups);
        }

        return redirect()->back()->with('successMessage', 'User was successfully added!');
    }

    /**
     * Show an user
     *
     * @param $id
     * @return array
     */
    public function show($id)
    {
        $user = User::find($id);
        return fractal($user, new UserTransformer())->toArray();
    }

    /**
     * Edit an user
     *
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function edit($id)
    {
        $user = User::find($id);
        return response()->json([
            'user' => $user,
            'userGroups' => $user->userGroups()->pluck('id')
        ]);
    }

    /**
     * Update an user
     *
     * @param UpdateUserRequest $request
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function update(UpdateUserRequest $request, $id)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! Users can\'t be changed.');
        }

        $user = User::find($id);
        $user->first_name = $request['first_name'];
        $user->last_name = $request['last_name'];
        $user->user_name = $request['user_name'];
        $user->email = $request['email'];
        $user->is_active = $request['is_active'];

        // If user is in-active, delete all sessions
        if($request['is_active'] == false) {
            if (config('session.driver') == 'database') {
                DB::connection(config('session.connection'))->table(config('session.table', 'sessions'))
                    ->where('user_id', $user->getAuthIdentifier())
                    ->delete();
            }
        }

        if($request['password'] != null || $request['password'] != '') {
            $user->password = Hash::make($request['password']);
        }

        $user->update();

        $user->syncRoles($request['role']);
        $user->userGroups()->sync($request->user_groups);

        return redirect()->back()->with('successMessage', 'User was successfully updated!');
    }

    /**
     * Delete an user
     *
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroy($id)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! Users can\'t be deleted.');
        }

        try {
            $user = User::find($id);

            if(!$user->canSecureDelete('practiceSessions', 'quizSessions')) {
                return redirect()->back()->with('errorMessage', 'Unable to Delete User . Remove all associations and Try again!');
            }

            $user->userGroups()->detach();
            $user->roles()->detach();
            $user->secureDelete('practiceSessions', 'quizSessions');
        }
        catch (\Illuminate\Database\QueryException $e){
            return redirect()->back()->with('errorMessage', 'Unable to Delete User . Remove all associations and Try again!');
        }
        return redirect()->back()->with('successMessage', 'User was successfully deleted!');
    }
}
