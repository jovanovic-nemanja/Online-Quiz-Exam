<?php
/**
 * File name: UpdateCategoryRequest.php
 * Last modified: 27/07/21, 1:03 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Requests\Admin;


use Illuminate\Foundation\Http\FormRequest;

class UpdateCategoryRequest extends FormRequest
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
            'name' => ['required', 'max:100'],
            'short_description' => ['nullable', 'max:160'],
            'description' => ['nullable', 'max:10000'],
            'image_path' => ['nullable', 'max:255'],
            'is_active' => ['required'],
        ];
	}
}
