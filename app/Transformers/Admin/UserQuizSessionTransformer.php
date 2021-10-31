<?php

namespace App\Transformers\Admin;

use App\Models\Quiz;
use App\Models\QuizSession;
use Jenssegers\Agent\Agent;
use League\Fractal\TransformerAbstract;

class UserQuizSessionTransformer extends TransformerAbstract
{
    /**
     * @var Quiz
     */
    private Quiz $quiz;

    public function __construct(Quiz $quiz)
    {
        $this->quiz = $quiz;
    }

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
        $browser_version = $agent->version($browser);

        $platform = $agent->platform();
        $platform_version = $agent->version($platform);
        return [
            'id' => $session->code,
            'slug' => $this->quiz->slug,
            'name' => "{$session->user->first_name} {$session->user->last_name}",
            'email' => $session->user->email,
            'user_photo' => $session->user->profile_photo_url,
            'accuracy' => round($session->results->accuracy, 1).'%',
            'percentage' => round($session->results->percentage, 1).'%',
            'score' => round($session->results->score, 1).'/'.$session->results->total_marks,
            'status' => $session->results->pass_or_fail,
            'ip' => $session->results->ip_address,
            'results' => $session->results,
            'device' => ucwords($agent->deviceType()),
            'os' => "{$platform} {$platform_version}",
            'browser' => "{$browser} {$browser_version}",
            'completed' => $session->completed_at->toDayDateTimeString()
        ];
    }
}
