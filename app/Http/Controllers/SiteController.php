<?php
/**
 * File name: SiteController.php
 * Last modified: 06/07/21, 11:42 AM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Controllers;

use App\Settings\HomePageSettings;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

class SiteController extends Controller
{
    /**
     * Welcome page, returns login page
     *
     * @param HomePageSettings $settings
     * @return \Inertia\Response
     */
    public function index(HomePageSettings $settings)
    {
        Inertia::share('homePageSettings', $settings->toArray());
        return Inertia::render('Auth/Login', [
            'canResetPassword' => Route::has('password.request'),
            'status' => session('status'),
        ]);
    }
}
