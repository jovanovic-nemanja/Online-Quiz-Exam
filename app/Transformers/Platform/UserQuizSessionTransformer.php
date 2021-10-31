<?php
/**
 * File name: UserQuizSessionTransformer.php
 * Last modified: 16/07/21, 11:36 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Transformers\Platform;

use App\Models\QuizSession;
use League\Fractal\TransformerAbstract;

class UserQuizSessionTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param QuizSession $session
     * @return array
     */
    public function transform(QuizSession $session)
    {
        return [
            'id' => $session->code,
            'slug' => $session->quiz->slug,
            'name' => $session->quiz->title,
            'accuracy' => $session->results->accuracy,
            'percentage' => $session->results->percentage.'%',
            'score' => $session->results->score.'/'.$session->results->total_marks,
            'status' => $session->results->pass_or_fail,
            'completed' => $session->completed_at->toFormattedDateString()
        ];
    }
}
