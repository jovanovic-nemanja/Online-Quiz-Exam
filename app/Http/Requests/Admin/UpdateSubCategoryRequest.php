<?php
/**
 * File name: UpdateSubCategoryRequest.php
 * Last modified: 27/07/21, 1:04 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Requests\Admin;


use Illuminate\Foundation\Http\FormRequest;

class UpdateSubCategoryRequest extends FormRequest
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
            'category_id' => ['required'],
            'sub_category_type_id' => ['required'],
            'short_description' => ['nullable', 'max:255'],
            'description' => ['nullable', 'max:5000'],
            'image_path' => ['nullable', 'max:255'],
            'is_active' => ['required'],
        ];
    }
}

