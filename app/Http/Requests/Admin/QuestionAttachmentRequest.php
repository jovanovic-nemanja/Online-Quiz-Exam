<?php
/**
 * File name: QuestionAttachmentRequest.php
 * Last modified: 18/07/21, 11:18 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Requests\Admin;

use Illuminate\Foundation\Http\FormRequest;

class QuestionAttachmentRequest extends FormRequest
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
        $rules = [
            'has_attachment' => ['required'],
            'attachment_type' => ['required_if:has_attachment,true']
        ];
        if($this->get('has_attachment')) {
            $rules['comprehension_id'] = ['required_if:attachment_type,comprehension'];
        }

        return $rules;
    }
}
