<?php
/**
 * File name: UpdatePracticeSetSettingsRequest.php
 * Last modified: 11/07/21, 10:57 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Requests\Admin;

use Illuminate\Foundation\Http\FormRequest;

class UpdatePracticeSetSettingsRequest extends FormRequest
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
            'auto_grading' => ['required'],
            'correct_marks' => ['required_if:auto_grading,false'],
        ];
    }
}
