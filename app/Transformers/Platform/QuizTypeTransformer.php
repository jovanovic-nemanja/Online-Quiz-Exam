<?php
/**
 * File name: QuizTypeTransformer.php
 * Last modified: 18/07/21, 12:56 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Transformers\Platform;

use App\Models\QuizType;
use Illuminate\Support\Str;
use League\Fractal\TransformerAbstract;

class QuizTypeTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param QuizType $quizType
     * @return array
     */
    public function transform(QuizType $quizType)
    {
        return [
            'slug' => $quizType->slug,
            'code' => $quizType->code,
            'name' => Str::plural($quizType->name),
            'latest_quiz' => $quizType->quizzes ? fractal($quizType->latestQuiz, new QuizCardTransformer())
                ->toArray()['data'] : null
        ];
    }
}
