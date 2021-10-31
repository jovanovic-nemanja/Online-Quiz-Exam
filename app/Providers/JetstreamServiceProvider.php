<?php

namespace App\Providers;

use App\Actions\Jetstream\DeleteUser;
use App\Settings\HomePageSettings;
use App\Settings\SiteSettings;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\ServiceProvider;
use Inertia\Inertia;
use Laravel\Fortify\Fortify;
use Laravel\Jetstream\Jetstream;
use Illuminate\Http\Request;

class JetstreamServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        $this->configurePermissions();

        Jetstream::deleteUsersUsing(DeleteUser::class);

        // Customized Login Redirect
        $this->app->singleton(
            \Laravel\Fortify\Contracts\LoginResponse::class,
            \App\Http\Responses\LoginResponse::class
        );

        $this->app->singleton(
            \Laravel\Fortify\Contracts\TwoFactorLoginResponse::class,
            \App\Http\Responses\LoginResponse::class
        );

        Fortify::loginView(function () {
            $settings = app(HomePageSettings::class);
            Inertia::share('homePageSettings', $settings->toArray());
            return Inertia::render('Auth/Login', [
                'canResetPassword' => Route::has('password.request'),
                'status' => session('status'),
            ]);
        });

        Fortify::registerView(function () {
            $settings = app(HomePageSettings::class);
            $canRegister = app(SiteSettings::class)->can_register;

            if(!$canRegister) {
                abort(403, 'Registration Not Allowed.');
            }

            Inertia::share('homePageSettings', $settings->toArray());

            return Inertia::render('Auth/Register', [
                'status' => session('status'),
            ]);
        });

        Jetstream::inertia()->whenRendering(
            'Profile/Show',
            function (Request $request, array $data) {
                return array_merge($data, [
                    'isAdmin' => Auth::user()->hasAnyRole(['admin', 'instructor'])
                ]);
            }
        );
    }

    /**
     * Configure the permissions that are available within the application.
     *
     * @return void
     */
    protected function configurePermissions()
    {
        Jetstream::defaultApiTokenPermissions(['read']);

        Jetstream::permissions([
            'create',
            'read',
            'update',
            'delete',
        ]);
    }
}
