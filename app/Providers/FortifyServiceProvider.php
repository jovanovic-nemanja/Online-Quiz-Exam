<?php

namespace App\Providers;

use App\Actions\Fortify\CreateNewUser;
use App\Actions\Fortify\ResetUserPassword;
use App\Actions\Fortify\UpdateUserPassword;
use App\Actions\Fortify\UpdateUserProfileInformation;
use App\Models\User;
use Illuminate\Cache\RateLimiting\Limit;
use Illuminate\Contracts\Auth\StatefulGuard;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\RateLimiter;
use Illuminate\Support\ServiceProvider;
use Illuminate\Validation\ValidationException;
use Laravel\Fortify\Fortify;

class FortifyServiceProvider extends ServiceProvider
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
        Fortify::createUsersUsing(CreateNewUser::class);
        Fortify::updateUserProfileInformationUsing(UpdateUserProfileInformation::class);
        Fortify::updateUserPasswordsUsing(UpdateUserPassword::class);
        Fortify::resetUserPasswordsUsing(ResetUserPassword::class);

        RateLimiter::for('login', function (Request $request) {
            return Limit::perMinute(5)->by($request->email.$request->ip());
        });

        RateLimiter::for('two-factor', function (Request $request) {
            return Limit::perMinute(5)->by($request->session()->get('login.id'));
        });

        Fortify::authenticateUsing(function (Request $request) {
            $user = User::where('email', $request->email)->orWhere('user_name', $request->email)->first();

            //Check whether user is active, if not throw error
            if($user && !$user->is_active) {
                throw ValidationException::withMessages([
                    Fortify::username() => ['Your login has been disabled. Please contact administrator.'],
                ]);
            }

            if ($user && Hash::check($request->password, $user->password)) {
                if(!config('qwiktest.demo_mode')) {
                    //Delete Other Browser Sessions on Login
                    $guard = app(StatefulGuard::class);
                    $guard->logoutOtherDevices($request->password);
                    if (config('session.driver') == 'database') {
                        DB::connection(config('session.connection'))->table(config('session.table', 'sessions'))
                            ->where('user_id', $user->getAuthIdentifier())
                            ->where('id', '!=', $request->session()->getId())
                            ->delete();
                    }
                }

                return $user;
            }
            return null;
        });
    }
}
