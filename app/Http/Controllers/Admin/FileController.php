<?php
/**
 * File name: FileController.php
 * Last modified: 19/07/21, 12:55 AM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;

class FileController extends Controller
{
    public function __construct()
    {
        $this->middleware(['role:admin'])->only('index');
    }

    /**
     * Access to File Manager
     *
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Contracts\View\View|\Illuminate\Http\RedirectResponse
     */
    public function index()
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! File manager can\'t be accessed.');
        }

        return view('file-manager');
    }

    /**
     * File manager CKEditor
     *
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Contracts\View\View|\Illuminate\Http\RedirectResponse
     */
    public function ckeditor()
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! File manager can\'t be accessed.');
        }

        return view('vendor.file-manager.ckeditor');
    }

    /**
     * File manager Button
     *
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Contracts\View\View|\Illuminate\Http\RedirectResponse
     */
    public function button()
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! File manager can\'t be accessed.');
        }

        return view('vendor.file-manager.fmButton');
    }
}
