<?php
/**
 * File name: QuestionPreviewTransformer.php
 * Last modified: 01/06/21, 1:22 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Transformers\Admin;

use App\Models\Question;
use League\Fractal\TransformerAbstract;

class QuestionPreviewTransformer extends TransformerAbstract
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
            'id' => $question->id,
            'code' => $question->code,
            'question' => formatQuestionProperty($question->question, $question->questionType->code),
            'skill' => $question->skill->name,
            'question_type' => $question->questionType->code,
            'question_type_name' => $question->questionType->name,
            'difficulty' => $question->difficultyLevel->name,
            'marks' => $question->default_marks,
            'options' => $question->options,
            'correct_answer' => $question->correct_answer,
            'attachment' => $this->getAttachmentType($question),
            'disabled' => false
        ];
    }

    /**
     * Get attachment type of a question
     *
     * @param $question
     * @return string
     */
    public function getAttachmentType($question)
    {
        if($question->has_audio) {
            return "Audio";
        } else if ($question->has_video) {
            return "Video";
        } else if ($question->has_comprehension) {
            return "Comprehension Passage";
        } else {
            return "No Attachment";
        }
    }
}
