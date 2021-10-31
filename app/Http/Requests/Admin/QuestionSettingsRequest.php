<?php
/**
 * File name: QuestionSettingsRequest.php
 * Last modified: 10/07/21, 11:58 AM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Requests\Admin;

use Illuminate\Foundation\Http\FormRequest;

class QuestionSettingsRequest extends FormRequest
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
            'skill_id' => ['required'],
            'topic_id' => ['nullable'],
            'difficulty_level_id' => ['required'],
            'is_active' => ['required'],
            'default_marks' => ['required'],
            'default_time' => ['required'],
        ];
    }
}
