<?php
/**
 * File name: QuizSearchTransformer.php
 * Last modified: 18/06/21, 2:45 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Transformers\Admin;

use App\Models\Quiz;
use League\Fractal\TransformerAbstract;

class QuizSearchTransformer extends TransformerAbstract
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
            'title' => $quiz->title
        ];
    }
}
