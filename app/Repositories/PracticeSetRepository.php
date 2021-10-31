<?php
/**
 * File name: PracticeSetRepository.php
 * Last modified: 11/07/21, 10:47 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Repositories;


use Illuminate\Support\Facades\DB;

class PracticeSetRepository
{
    /**
     * PracticeSet Configuration Steps
     *
     * @param null $pId
     * @param string $active
     * @return array[]
     */
    public function getSteps($pId = null, $active = 'details')
    {
        return [
            [
                'step' => 1,
                'key' => 'details',
                'title' => 'Details',
                'status' => $active == 'details' ? 'active' : 'inactive',
                'url' => $pId != null ? route('practice-sets.edit', ['practice_set' => $pId]) : ''
            ],
            [
                'step' => 2,
                'key' => 'settings',
                'title' => 'Settings',
                'status' => $active == 'settings' ? 'active' : 'inactive',
                'url' => $pId != null ? route('practice-sets.settings', ['practice_set' => $pId]) : ''
            ],
            [
                'step' => 3,
                'key' => 'questions',
                'title' => 'Questions',
                'status' => $active == 'questions' ? 'active' : 'inactive',
                'url' => $pId != null ? route('practice-sets.questions', ['practice_set' => $pId]) : ''
            ],
        ];
    }

    /**
     * Practice Set Overall Stats Query
     *
     * @param $practiceSetId
     * @return mixed
     */
    public function getPracticeSessionStats($practiceSetId)
    {
        return DB::table('practice_sessions')
            ->where('practice_set_id', '=', $practiceSetId)
            ->where('status', '=', 'completed')
            ->selectRaw("count(case when status = 'completed' then 1 end) as total_attempts")
            ->selectRaw("count(DISTINCT(user_id)) as unique_test_takers")
            ->selectRaw("avg(total_time_taken) as avg_time")
            ->selectRaw("avg(total_points_earned) as avg_score")
            ->selectRaw("avg(results->>'$.accuracy') as avg_accuracy")
            ->selectRaw("avg(results->>'$.speed') as avg_speed")
            ->selectRaw("max(total_points_earned) as high_score")
            ->selectRaw("min(total_points_earned) as low_score")
            ->get();
    }
}
