<?php
/**
 * File name: HomeController.php
 * Last modified: 18/05/21, 3:10 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;

class HomeController extends Controller
{
    /**
     * Redirect to dashboard after login based on user role
     *
     * @return \Illuminate\Http\RedirectResponse
     */
    public function index()
    {
        if (Auth::user()->hasRole('admin')) {
            return redirect()->route('admin_dashboard');
        } elseif (Auth::user()->hasRole(['guest', 'student', 'employee'])) {
            return redirect()->route('user_dashboard');
        } elseif (Auth::user()->hasRole('instructor')) {
            return redirect()->route('instructor_dashboard');
        } elseif (Auth::user()->hasRole('parent')) {
            return redirect()->route('parent_dashboard');
        } else {
            return redirect()->route('user_dashboard');
        }
    }

    /**
     * Set app locale request
     *
     * @param $locale
     * @return \Illuminate\Http\RedirectResponse
     */
    public function setLocale($locale)
    {
        session()->put('locale', $locale);
        return redirect()->back();
    }
}
