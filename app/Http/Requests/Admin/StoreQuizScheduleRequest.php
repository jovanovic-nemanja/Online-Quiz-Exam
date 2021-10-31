<?php
/**
 * File name: StoreQuizScheduleRequest.php
 * Last modified: 27/07/21, 1:02 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Http\Requests\Admin;

use Illuminate\Foundation\Http\FormRequest;

class StoreQuizScheduleRequest extends FormRequest
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
            'quiz_id' => ['required'],
            'schedule_type' => ['required'],
            'grace_period' => ['required', 'min:1'],
            'start_date' => ['required', 'date_format:Y-m-d'],
            'start_time' => ['required', 'date_format:H:i:s'],
            'user_groups' => ['required'],
            'status' => ['required'],
        ];

        // conditionally validate end date and time based on start date & time
        if($this->get('schedule_type') == 'flexible') {
            $rules['end_date'] = ['required_if:schedule_type,flexible', 'date_format:Y-m-d', 'after_or_equal:start_date'];
            $rules['end_time'] = ['required_if:schedule_type,flexible', 'date_format:H:i:s',
                $this->get('start_date') == $this->get('end_date') ? 'after:start_time' : ''];
        }

        return $rules;
    }

}
