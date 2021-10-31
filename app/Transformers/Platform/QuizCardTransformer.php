<?php
/**
 * File name: QuizCardTransformer.php
 * Last modified: 17/06/21, 12:41 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Transformers\Platform;

use App\Models\Quiz;
use League\Fractal\TransformerAbstract;

class QuizCardTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param Quiz $quiz
     * @return array
     */
    public function transform(Quiz $quiz)
    {
        return [
            'code' => $quiz->code,
            'title' => $quiz->title,
            'slug' => $quiz->slug,
            'total_questions' => $quiz->total_questions,
            'total_marks' => $quiz->total_marks,
            'total_duration' => $quiz->total_duration/60,
            'category' => $quiz->subCategory->name,
            'type' => $quiz->quizType->name,
            'redeem' => $quiz->can_redeem ? $quiz->points_required.' XP' : 'Free',
        ];
    }
}
