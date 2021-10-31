<?php
/**
 * File name: QuizUpdateAnswerRequest.php
 * Last modified: 12/06/21, 7:34 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Requests\Platform;

use Illuminate\Foundation\Http\FormRequest;

class QuizUpdateAnswerRequest extends FormRequest
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
            'user_answer' => ['nullable'],
            'time_taken' => ['required', 'numeric'],
            'status' => ['required', 'string']
        ];
    }
}
