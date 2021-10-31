<?php

namespace App\Http\Responses;

use Illuminate\Support\Facades\Auth;
use Laravel\Fortify\Contracts\LoginResponse as LoginResponseContract;

class LoginResponse implements LoginResponseContract
{

    public function toResponse($request)
    {
        // Redirect to dashboard based on role
        if(Auth::user()->hasRole("admin"))
            return redirect()->route('admin_dashboard');
        return redirect()->intended(config('fortify.home'));
    }

}
