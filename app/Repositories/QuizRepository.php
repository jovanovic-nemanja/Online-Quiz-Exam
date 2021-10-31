<?php
/**
 * File name: QuizRepository.php
 * Last modified: 10/07/21, 3:08 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Repositories;


use Illuminate\Support\Facades\DB;

class QuizRepository
{
    /**
     * Quiz Configuration Steps
     *
     * @param null $qId
     * @param string $active
     * @return array[]
     */
    public function getSteps($qId = null, $active = 'details')
    {
        return [
            [
                'step' => 1,
                'key' => 'details',
                'title' => 'Details',
                'status' => $active == 'details' ? 'active' : 'inactive',
                'url' => $qId != null ? route('quizzes.edit', ['quiz' => $qId]) : ''
            ],
            [
                'step' => 2,
                'key' => 'settings',
                'title' => 'Settings',
                'status' => $active == 'settings' ? 'active' : 'inactive',
                'url' => $qId != null ? route('quizzes.settings', ['quiz' => $qId]) : ''
            ],
            [
                'step' => 3,
                'key' => 'questions',
                'title' => 'Questions',
                'status' => $active == 'questions' ? 'active' : 'inactive',
                'url' => $qId != null ? route('quizzes.questions', ['quiz' => $qId]) : ''
            ],
            [
                'step' => 4,
                'key' => 'schedules',
                'title' => 'Schedules',
                'status' => $active == 'schedules' ? 'active' : 'inactive',
                'url' => $qId != null ? route('quizzes.schedules.index', ['quiz' => $qId]) : ''
            ]
        ];
    }

    /**
     * Quiz Overall Stats Query
     *
     * @param $quizId
     * @param $scheduleId
     * @return \Illuminate\Support\Collection
     */
    public function getQuizSessionStats($quizId, $scheduleId)
    {
        $key = $scheduleId ? 'quiz_schedule_id' : 'quiz_id';
        $value = $scheduleId ? $scheduleId : $quizId;
        return DB::table('quiz_sessions')
            ->where($key, '=', $value)
            ->selectRaw("count(case when status = 'completed' then 1 end) as total_attempts")
            ->selectRaw("count(case when json_extract(results,'$.pass_or_fail') = 'Passed' then 1 end) as pass_count")
            ->selectRaw("count(case when json_extract(results, '$.pass_or_fail')= 'Failed' then 1 end) as failed_count")
            ->selectRaw("count(DISTINCT(user_id)) as unique_test_takers")
            ->selectRaw("avg(total_time_taken) as avg_time")
            ->selectRaw("avg(json_extract(results,'$.score')) as avg_score")
            ->selectRaw("avg(json_extract(results,'$.percentage')) as avg_percentage")
            ->selectRaw("avg(json_extract(results,'$.accuracy')) as avg_accuracy")
            ->selectRaw("avg(json_extract(results,'$.speed')) as avg_speed")
            ->selectRaw("max(json_extract(results,'$.score')) as high_score")
            ->selectRaw("min(json_extract(results,'$.score')) as low_score")
            ->selectRaw("sum(json_extract(results,'$.answered_questions')) as sum_answered")
            ->selectRaw("sum(json_extract(results,'$.total_questions')) as sum_questions")
            ->get();
    }

    /**
     * Get quiz statuses
     *
     * @return array[]
     */
    public function getQuizStatuses()
    {
        return [
            ['value' => 1, 'text' => 'Drafts'],
            ['value' => 2, 'text' => 'Published'],
            ['value' => 3, 'text' => 'Cancelled'],
            ['value' => 4, 'text' => 'Expired']
        ];
    }
}
