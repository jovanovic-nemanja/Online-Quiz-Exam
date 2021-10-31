<?php
/**
 * File name: UserPracticeSessionTransformer.php
 * Last modified: 16/07/21, 11:36 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Transformers\Platform;

use App\Models\PracticeSession;
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
        return [
            'id' => $session->code,
            'slug' => $session->practiceSet->slug,
            'name' => $session->practiceSet->title,
            'total_points_earned' => $session->total_points_earned.' XP',
            'completed' => $session->completed_at->toFormattedDateString()
        ];
    }
}
