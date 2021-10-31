<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\QuizSchedule;
use App\Settings\LocalizationSettings;
use Carbon\Carbon;
use Inertia\Inertia;
use Artisan;

class MaintenanceController extends Controller
{
    public function __construct()
    {
        $this->middleware(['role:admin']);
    }

    /**
     * Application maintenance page
     *
     * @return \Inertia\Response
     */
    public function index()
    {
        return Inertia::render('Admin/Settings/MaintenanceSettings', [
            'appVersion' => config('qwiktest.version')
        ]);
    }

    /**
     * Clear application cache
     *
     * @return \Illuminate\Http\RedirectResponse
     */
    public function clearCache()
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! These settings can\'t be changed.');
        }

        Artisan::call('cache:forget', ['key' => 'spatie.permission.cache']);
        Artisan::call('config:clear');
        Artisan::call('cache:clear');
        Artisan::call('view:clear');
        Artisan::call('route:clear');

        return redirect()->back()->with('successMessage', 'Cache cleared successfully.');
    }

    /**
     * Mark completed schedules as expired
     *
     * @param LocalizationSettings $localization
     * @return \Illuminate\Http\RedirectResponse
     */
    public function expireSchedules(LocalizationSettings $localization)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! These settings can\'t be changed.');
        }

        $now = Carbon::now()->timezone($localization->default_timezone);

        $schedules = QuizSchedule::where('end_date', '<=', $now->toDateString())
            ->where('end_time', '<=', $now->toTimeString())
            ->where('status', '=', 'active')->get();

        foreach ($schedules as $schedule) {
            $schedule->status = 'expired';
            $schedule->save();
        }

        return redirect()->back()->with('successMessage', 'Schedules updated successfully.');
    }
}
