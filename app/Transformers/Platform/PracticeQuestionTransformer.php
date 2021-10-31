<?php
/**
 * File name: PracticeQuestionTransformer.php
 * Last modified: 17/07/21, 8:59 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Transformers\Platform;

use App\Models\Question;
use League\Fractal\TransformerAbstract;

class PracticeQuestionTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param Question $question
     * @return array
     */
    public function transform(Question $question)
    {
        $hasSession = count($question->practiceSessions) > 0;
        return [
            'code' => $question->code,
            'question' => formatQuestionProperty($question->question, $question->questionType->code),
            'attachment_type' => $question->has_attachment ? $question->attachment_type : null,
            'attachment' => $question->has_attachment ? $this->getAttachment($question) : null,
            'options' => formatOptionsProperty($question->options, $question->questionType->code, $question->question),
            'questionType' => $question->questionType->code,
            'skill' => $question->skill->name,
            'user_answer' => $hasSession ? unserialize($question->practiceSessions[0]->pivot->user_answer) : formatAnswerProperty($question->questionType->code),
            'is_correct' => (boolean)$hasSession ? $question->practiceSessions[0]->pivot->is_correct ? true : false : null,
            'time_taken' => $hasSession ? $question->practiceSessions[0]->pivot->time_taken : 0,
            'status' => $hasSession ? $question->practiceSessions[0]->pivot->status : null,
            'points_earned' => $hasSession ? $question->practiceSessions[0]->pivot->points_earned : 0,
            'solution' => $hasSession && $question->practiceSessions[0]->pivot->status == 'answered' ? $question->solution : '',
            'ca' => $hasSession && $question->practiceSessions[0]->pivot->status == 'answered' ?
                unserialize($question->practiceSessions[0]->pivot->correct_answer) : null, // Correct Answer
        ];
    }

    /**
     * Get attachment type of a question
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
