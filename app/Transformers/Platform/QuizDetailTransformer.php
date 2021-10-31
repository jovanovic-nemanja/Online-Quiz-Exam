<?php
/**
 * File name: QuizDetailTransformer.php
 * Last modified: 17/06/21, 1:12 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Transformers\Platform;

use App\Models\Quiz;
use League\Fractal\TransformerAbstract;

class QuizDetailTransformer extends TransformerAbstract
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
            'description' => $quiz->description !== null ? $quiz->description : 'No Description',
            'price' => $quiz->is_paid ? $quiz->price : 'Free',
            'can_redeem' => $quiz->can_redeem,
            'redeem' => $quiz->can_redeem ? $quiz->points_required.' XP' : 'Free',
            'total_questions' => $quiz->total_questions,
            'total_marks' => $quiz->total_marks,
            'total_duration' => $quiz->total_duration/60,
            'category' => $quiz->subCategory->name,
            'type' => $quiz->quizType->name,
            'uncompleted_sessions' => $quiz->sessions_count
        ];
    }
}
