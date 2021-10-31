<?php

namespace App\Transformers\Admin;

use App\Models\Quiz;
use App\Models\QuizSession;
use Jenssegers\Agent\Agent;
use League\Fractal\TransformerAbstract;

class QuizScoreReportTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param QuizSession $session
     * @return array
     */
    public function transform(QuizSession $session)
    {
        $agent = new Agent();
        $agent->setUserAgent($session->results->user_agent);
        $browser = $agent->browser();

        $platform = $agent->platform();
        $platform_version = $agent->version($platform);
        return [
            'id' => $session->code,
            'completed_at' => $session->completed_at->toDayDateTimeString(),
            'user' => "{$session->user->first_name} {$session->user->last_name}",
            'email' => $session->user->email,
            'status' => $session->results->pass_or_fail,
            'ip' => $session->results->ip_address,
            'device' => ucwords($agent->deviceType()),
            'os' => "{$platform} {$platform_version}",
            'browser' => "{$browser}",
            'properties' => [
                [
                    [
                        'key' => "Total Questions",
                        'value' => $session->results->total_questions.'Q'
                    ],
                    [
                        'key' => "Correct",
                        'value' => $session->results->correct_answered_questions.'Q'
                    ]
                ],
                [
                    [
                        'key' => "Answered",
                        'value' => $session->results->answered_questions.'Q'
                    ],
                    [
                        'key' => "Wrong",
                        'value' => $session->results->wrong_answered_questions.'Q'
                    ]
                ],
                [
                    [
                        'key' => "Quiz Marks",
                        'value' => $session->results->total_marks
                    ],
                    [
                        'key' => "Quiz Time",
                        'value' => $session->results->total_duration.' Minutes'
                    ],
                ],
                [
                    [
                        'key' => "Positive Marks",
                        'value' => $session->results->marks_earned
                    ],
                    [
                        'key' => "Time Taken",
                        'value' => $session->results->total_time_taken['detailed_readable']
                    ]
                ],
                [
                    [
                        'key' => "Negative Marks",
                        'value' => $session->results->marks_deducted
                    ],
                    [
                        'key' => "Pass Percentage",
                        'value' => round($session->results->cutoff, 1).'%'
                    ]
                ],
                [
                    [
                        'key' => "Final Score",
                        'value' => round($session->results->score, 1)
                    ],
                    [
                        'key' => "Final Percentage",
                        'value' => round($session->results->percentage, 1).'%',
                    ]
                ],
                [
                    [
                        'key' => "Accuracy",
                        'value' => round($session->results->accuracy, 1).'%'
                    ],
                    [
                        'key' => "Speed",
                        'value' => round($session->results->speed, 0).' Q/Hr',
                    ]
                ],
            ],
        ];
    }
}
