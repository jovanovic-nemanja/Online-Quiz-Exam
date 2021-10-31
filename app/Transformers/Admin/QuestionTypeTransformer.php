<?php
/**
 * File name: QuestionTypeTransformer.php
 * Last modified: 06/05/21, 11:59 AM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Transformers\Admin;

use App\Models\QuestionType;
use League\Fractal\TransformerAbstract;

class QuestionTypeTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param QuestionType $questionType
     * @return array
     */
    public function transform(QuestionType $questionType)
    {
        return [
            'id' => $questionType->id,
            'name' => $questionType->name,
            'code' => $questionType->code,
            'short_description' => $questionType->short_description,
            'status' => $questionType->is_active ? 'Active' : 'In-active',
        ];
    }
}
