<?php
/**
 * File name: QuizQuestionTransformer.php
 * Last modified: 17/07/21, 8:59 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Transformers\Platform;

use App\Models\Question;
use League\Fractal\TransformerAbstract;

class QuizQuestionTransformer extends TransformerAbstract
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
            'question' => formatQuestionProperty($question->question, $question->questionType->code),
            'attachment_type' => $question->has_attachment ? $question->attachment_type : null,
            'attachment' => $question->has_attachment ? $this->getAttachment($question) : null,
            'options' => unserialize($question->pivot->options),
            'questionType' => $question->questionType->code,
            'skill' => $question->skill->name,
            'time_taken' => $question->pivot->time_taken,
            'user_answer' => $question->pivot->user_answer != null ? unserialize($question->pivot->user_answer) : formatAnswerProperty($question->questionType->code),
            'status' => $question->pivot->status,
        ];
    }

    /**
     * Get attachment of a question
     *
     * @param $question
     * @return |null
     */
    public function getAttachment($question)
    {
        if($question->attachment_type == 'comprehension') {
            return $question->comprehensionPassage->body;
        }
        if($question->attachment_type == 'audio' || $question->attachment_type == 'video') {
            return $question->attachment_options;
        }
        return null;
    }
}
