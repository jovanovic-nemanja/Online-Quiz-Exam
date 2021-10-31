<?php
/**
 * File name: UpdatePracticeSetRequest.php
 * Last modified: 27/07/21, 1:03 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Requests\Admin;

use Illuminate\Foundation\Http\FormRequest;

class UpdatePracticeSetRequest extends FormRequest
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
            'title' => ['required', 'max:160'],
            'description' => ['nullable'],
            'sub_category_id' => ['required'],
            'is_active' => ['required'],
        ];
    }
}

