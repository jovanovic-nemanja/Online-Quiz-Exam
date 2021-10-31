<?php
/**
 * File name: ExpireSchedules.php
 * Last modified: 18/07/21, 11:53 AM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Console\Commands;

use App\Models\QuizSchedule;
use App\Settings\LocalizationSettings;
use Carbon\Carbon;
use Illuminate\Console\Command;

class ExpireSchedules extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'expire:schedules';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command to expire quiz/exam schedules after passing end date time';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $localization = app(LocalizationSettings::class);
        $now = Carbon::now()->timezone($localization->default_timezone);

        // fetch all the schedules that passed end date
        $schedules = QuizSchedule::where('end_date', '<=', $now->toDateString())
            ->where('end_time', '<=', $now->toTimeString())
            ->where('status', '=', 'active')->get();

        //set status as expired
        foreach ($schedules as $schedule) {
            $schedule->status = 'expired';
            $schedule->save();
        }
        return 1;
    }
}
