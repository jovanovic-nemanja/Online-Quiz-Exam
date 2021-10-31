<?php

namespace App\Transformers\Admin;

use App\Models\PracticeSession;
use Jenssegers\Agent\Agent;
use League\Fractal\TransformerAbstract;

class UserPracticeSessionTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param PracticeSession $session
     * @return array
     */
    public function transform(PracticeSession $session)
    {
        $agent = new Agent();
        $agent->setUserAgent($session->results->user_agent);
        $browser = $agent->browser();
        $browser_version = $agent->version($browser);

        $platform = $agent->platform();
        $platform_version = $agent->version($platform);

        return [
            'id' => $session->code,
            'slug' => $session->practiceSet->slug,
            'name' => "{$session->user->first_name} {$session->user->last_name}",
            'email' => $session->user->email,
            'total_points_earned' => $session->total_points_earned.' XP',
            'accuracy' => $session->results->accuracy.'%',
            'speed' => $session->results->speed.' que/hr',
            'ip' => $session->results->ip_address,
            'completed' => $session->completed_at->toDayDateTimeString(),
            'status' => ucfirst($session->status),
            'device' => ucwords($agent->deviceType()),
            'os' => "{$platform} {$platform_version}",
            'browser' => "{$browser} {$browser_version}",
        ];
    }
}
