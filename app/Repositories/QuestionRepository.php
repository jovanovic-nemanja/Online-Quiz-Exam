<?php
/**
 * File name: QuestionRepository.php
 * Last modified: 09/07/21, 10:33 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Repositories;

use App\Models\DifficultyLevel;
use App\Models\Question;
use App\Models\QuestionType;

class QuestionRepository
{
    /**
     * Question Configuration Steps
     *
     * @param null $qId
     * @param string $active
     * @return array[]
     */
    public function getSteps($qId = null, $active = 'details')
    {
        return [
            [
                'step' => 1,
                'key' => 'details',
                'title' => 'Details',
                'status' => $active == 'details' ? 'active' : 'inactive',
                'url' => $qId != null ? route('questions.edit', ['question' => $qId]) : ''
            ],
            [
                'step' => 2,
                'key' => 'settings',
                'title' => 'Settings',
                'status' => $active == 'settings' ? 'active' : 'inactive',
                'url' => $qId != null ? route('question_settings', ['id' => $qId]) : ''
            ],
            [
                'step' => 3,
                'key' => 'solution',
                'title' => 'Solution',
                'status' => $active == 'solution' ? 'active' : 'inactive',
                'url' => $qId != null ? route('question_solution', ['id' => $qId]) : ''
            ],
            [
                'step' => 4,
                'key' => 'attachment',
                'title' => 'Attachment',
                'status' => $active == 'attachment' ? 'active' : 'inactive',
                'url' => $qId != null ? route('question_attachment', ['id' => $qId]) : ''
            ]
        ];
    }

    /**
     * Restrict adding manually evaluated questions when auto evaluation enabled
     *
     * @param $questionType
     * @return bool
     */
    public function checkAutoEvaluationEligibility($questionType)
    {
        if($questionType == 'LAQ') {
            return false;
        }

        return true;
    }

    /**
     * check if user chosen answer is correct or not
     *
     * @param Question $question
     * @param $userAnswer
     * @return bool
     */
    public function evaluateAnswer(Question $question, $userAnswer)
    {
        switch ($question->questionType->code) {
            case 'PQ':
            case 'MSA':
            case 'TOF':
                return validateMSA($question->correct_answer, $userAnswer);
                break;
            case 'MMA':
                return validateMMA($question->correct_answer, $userAnswer);
                break;
            case 'FIB':
                return validateFIB($question->correct_answer, $userAnswer);
                break;
            case 'SAQ':
                return validateSAQ($question->options, $userAnswer);
                break;
            case 'ORD':
                return validateORD($question->options, $userAnswer);
                break;
            case 'MTF':
                return validateMTF($question->options, $userAnswer);
                break;
            default:
                return false;
                break;
        }
    }

    /**
     * This method is to return formatted correct answer to show to user after test
     *
     * @param Question $question
     * @param $userAnswer
     * @return array|bool|mixed|string
     */
    public function formatCorrectAnswer(Question $question, $userAnswer)
    {
        if($question->questionType->code === 'MTF' || $question->questionType->code === 'PQ') {
            return validateMTF($question->options, $userAnswer, true);
        } else if ($question->questionType->code === 'ORD'){
            return validateORD($question->options, $userAnswer, true);
        } else if ($question->questionType->code === 'SAQ'){
            $options = [];
            foreach($question->options as $option) {
                array_push($options, $option['option']);
            }
            return $options;
        } else {
            return $question->correct_answer;
        }
    }

    /**
     * This method is to return default options array for creating question
     *
     * @param $qType
     * @return array
     */
    function setDefaultOptions($qType) {
        switch ($qType) {
            case 'PQ':
            case 'MSA':
            case 'MMA':
            case 'SAQ':
            case 'ORD':
                return [
                    ['option' => '', 'partial_weightage' => 0],
                    ['option' => '', 'partial_weightage' => 0]
                ];
                break;
            case 'TOF':
                return [
                    ['option' => 'True', 'partial_weightage' => 0],
                    ['option' => 'False', 'partial_weightage' => 0]
                ];
                break;
            case 'MTF':
                return [
                    ['option' => '', 'pair' => '', 'partial_weightage' => 0],
                    ['option' => '', 'pair' => '', 'partial_weightage' => 0],
                ];
                break;
            default:
                return [''];
                break;
        }
    }

    /**
     * This method is to return default preferences array for creating question
     *
     * @param $qType
     * @return array
     */
    function setDefaultPreferences($qType) {
        switch ($qType) {
            case 'FIB':
            case 'SAQ':
                return ['case_sensitive' => false, 'is_numeric' => false];
                break;
            case 'LAQ':
                return ['word_limit' => false, 'min_words' => 0, 'max_words' => 10];
                break;
            default:
                return [];
                break;
        }
    }

    /**
     * This method is to return default options array for creating question
     *
     * @param $qType
     * @return array|string
     */
    function setDefaultAnswers($qType) {
        switch ($qType) {
            case 'PQ':
            case 'MSA':
            case 'TOF':
            case 'SAQ':
            case 'MTF':
                return '';
                break;
            case 'MMA':
                return [];
                break;
            default:
                return [''];
                break;
        }
    }
}
