<?php

namespace App\Transformers\Admin;

use App\Models\PracticeSession;
use League\Fractal\TransformerAbstract;

class PracticeSessionExportTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param PracticeSession $session
     * @return array
     */
    public function transform(PracticeSession $session)
    {
        return [
            'user' => "{$session->user->first_name} {$session->user->last_name}",
            'email' => $session->user->email,
            'completed' => $session->completed_at->toDayDateTimeString(),
            'score' => round($session->total_points_earned, 0).' XP',
            'accuracy' => round($session->results->accuracy, 1).'%',
            'speed' => round($session->results->speed, 0).' q/hr',
            'status' => ucwords($session->status),
            'id' => $session->code,
        ];
    }
}
