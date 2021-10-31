<?php

namespace App\Transformers\Admin;

use App\Models\Quiz;
use App\Models\QuizSession;
use Jenssegers\Agent\Agent;
use League\Fractal\TransformerAbstract;

class QuizSessionExportTransformer extends TransformerAbstract
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
            'user' => "{$session->user->first_name} {$session->user->last_name}",
            'email' => $session->user->email,
            'completed' => $session->completed_at->toDayDateTimeString(),
            'score' => round($session->results->score, 1).'/'.$session->results->total_marks,
            'percentage' => round($session->results->percentage, 1).'% (Min. '.round($session->results->cutoff, 0).'%)',
            'accuracy' => round($session->results->accuracy, 1).'%',
            'speed' => round($session->results->speed, 0).' q/hr',
            'status' => $session->results->pass_or_fail,
            'ip' => $session->results->ip_address,
            'device' => ucwords($agent->deviceType()),
            'os' => "{$browser}, {$platform} {$platform_version}",
            'id' => $session->code,
        ];
    }
}
