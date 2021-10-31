<?php
/**
 * File name: UpdateQuizSettingsRequest.php
 * Last modified: 16/06/21, 6:03 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Requests\Admin;

use Illuminate\Foundation\Http\FormRequest;

class UpdateQuizSettingsRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'restrict_attempts' => ['required'],
            'no_of_attempts' => ['required_if:restrict_attempts,true'],
            'disable_question_navigation' => ['required'],
            'list_questions' => ['required'],
            'auto_duration' => ['required'],
            'total_duration' => ['required_if:auto_duration,false'],
            'auto_grading' => ['required'],
            'correct_marks' => ['required_if:auto_grading,false'],
            'cutoff' => ['required_if:enable_section_cutoff,true'],
            'enable_negative_marking' => ['required'],
            'negative_marking_type' => ['required_if:enable_negative_marking,true'],
            'negative_marks' => ['required_if:enable_negative_marking,true'],
            'disable_finish_button' => ['required'],
            'hide_solutions' => ['required']
        ];
    }
}
