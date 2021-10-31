<?php

namespace App\Http\Middleware;

use App\Settings\SiteSettings;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Middleware;

class HandleInertiaRequests extends Middleware
{
    /**
     * The root template that's loaded on the first page visit.
     *
     * @see https://inertiajs.com/server-side-setup#root-template
     * @var string
     */
    protected $rootView = 'app';

    /**
     * Determines the current asset version.
     *
     * @see https://inertiajs.com/asset-versioning
     * @param  \Illuminate\Http\Request  $request
     * @return string|null
     */
    public function version(Request $request)
    {
        return parent::version($request);
    }

    /**
     * Defines the props that are shared by default.
     *
     * @see https://inertiajs.com/shared-data
     * @param \Illuminate\Http\Request $request
     * @return array
     */
    public function share(Request $request)
    {
        $settings = app(SiteSettings::class);
        return array_merge(parent::share($request), [
            'general' => config('qwiktest.installed') ? $settings->toArray() : [],
            'canLogin' => \Route::has('login'),
            'canResetPassword' => \Route::has('password.request'),
            'isDemo' => config('qwiktest.demo_mode'),
            "appUrl" => config("app.url").'/',
            "assetUrl" => config("app.url").'/storage/',
            'successMessage' => session()->get('successMessage') ? session()->get('successMessage') : null,
            'errorMessage' => session()->get('errorMessage') ? session()->get('errorMessage') : null,
            'locale' => function () {
                return app()->getLocale();
            },
            'languages' => [
                'en' => 'English',
            ],
            'translations' => function () {
                return translations(
                    resource_path('lang/'. app()->getLocale() .'.json')
                );
            },
        ]);
    }
}
