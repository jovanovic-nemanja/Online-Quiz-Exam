<?php
/**
 * File name: AppInstallController.php
 * Last modified: 19/07/21, 3:10 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Controllers;

use Jackiedo\DotenvEditor\Facades\DotenvEditor;
use Artisan;

class AppInstallController extends Controller
{
    /**
     * Update env file, configure storage and cache after installation
     *
     * @return \Illuminate\Http\RedirectResponse
     */
    public function onSuccessfulInstall()
    {
        $installed = file_exists(storage_path('installed'));

        if($installed) {
            $env = DotenvEditor::load();
            $env->addEmpty();
            $env->setKey('APP_INSTALLED', 'true');
            $env->setKey('APP_VERSION', '1.1.0');
            $env->setKey('SESSION_DRIVER', 'database');
            $env->setKey('SESSION_LIFETIME', '43200');
            $env->save();

            Artisan::call('config:clear');
            Artisan::call('cache:clear');
            Artisan::call('storage:link');
        }

        return redirect()->route('welcome');
    }
}
