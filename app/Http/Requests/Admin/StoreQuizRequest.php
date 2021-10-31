<?php
/**
 * File name: StoreQuizRequest.php
 * Last modified: 27/07/21, 1:01 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Requests\Admin;

use Illuminate\Foundation\Http\FormRequest;

class StoreQuizRequest extends FormRequest
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
            'title' => ['required'],
            'description' => ['nullable'],
            'sub_category_id' => ['required'],
            'quiz_type_id' => ['required'],
            'can_redeem' => ['required'],
            'points_required' => ['required_if:can_redeem,true'],
            'is_private' => ['required'],
        ];
    }
}
