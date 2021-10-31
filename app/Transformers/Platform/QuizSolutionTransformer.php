<?php
/**
 * File name: QuizSolutionTransformer.php
 * Last modified: 16/07/21, 9:44 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Transformers\Platform;

use App\Models\Question;
use League\Fractal\TransformerAbstract;

class QuizSolutionTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param Question $question
     * @return array
     */
    public function transform(Question $question)
    {
        return [
            'code' => $question->code,
            'question' => $question->pivot->original_question,
            'options' => unserialize($question->pivot->options),
            'questionType' => $question->questionType->code,
            'skill' => $question->skill->name,
            'user_answer' => $question->pivot->user_answer != null ? unserialize($question->pivot->user_answer) : formatAnswerProperty($question->questionType->code),
            'is_correct' => (boolean) $question->pivot->is_correct,
            'time_taken' => formattedSeconds($question->pivot->time_taken),
            'status' => $question->pivot->status,
            'marks_earned' => $question->pivot->marks_earned,
            'marks_deducted' => $question->pivot->marks_deducted,
            'solution' => $question->solution,
            'ca' =>  unserialize($question->pivot->correct_answer),
        ];
    }
}
