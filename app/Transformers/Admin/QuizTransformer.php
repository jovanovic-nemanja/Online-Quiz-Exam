<?php
/**
 * File name: QuizTransformer.php
 * Last modified: 17/06/21, 4:02 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Transformers\Admin;

use App\Models\Quiz;
use League\Fractal\TransformerAbstract;

class QuizTransformer extends TransformerAbstract
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
            'id' => $quiz->id,
            'code' => $quiz->code,
            'title' => $quiz->title,
            'category' => $quiz->subCategory->name,
            'quizType' => $quiz->quizType->name,
            'questions' => $quiz->total_questions.' Questions',
            'schedules' => $quiz->quiz_schedules_count > 0 ? $quiz->quiz_schedules_count : 'No Schedules',
            'visibility' => $quiz->is_private ? 'Private' : 'Public',
            'status' => $quiz->is_active ? 'Published' : 'Draft',
        ];
    }
}
