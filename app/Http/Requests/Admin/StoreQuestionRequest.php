<?php
/**
 * File name: StoreQuestionRequest.php
 * Last modified: 10/07/21, 11:59 AM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Requests\Admin;

use Illuminate\Foundation\Http\FormRequest;

class StoreQuestionRequest extends FormRequest
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
            'question' => ['required'],
            'options' => ['nullable'],
            'correct_answer' => ['nullable'],
            'skill_id' => ['required'],
            'question_type_id' => ['required'],
        ];
    }
}
