<?php
/**
 * File name: QuizScheduleTransformer.php
 * Last modified: 17/07/21, 3:21 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Transformers\Admin;

use App\Models\QuizSchedule;
use League\Fractal\TransformerAbstract;

class QuizScheduleTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param QuizSchedule $quizSchedule
     * @return array
     */
    public function transform(QuizSchedule $quizSchedule)
    {
        return [
            'id' => $quizSchedule->id,
            'code' => $quizSchedule->code,
            'quiz' => $quizSchedule->quiz->title,
            'type' => ucfirst($quizSchedule->schedule_type),
            'starts_at' => $quizSchedule->starts_at->toDayDateTimeString(),
            'ends_at' => $quizSchedule->ends_at->toDayDateTimeString(),
            'status' => ucfirst($quizSchedule->status),
        ];
    }
}
