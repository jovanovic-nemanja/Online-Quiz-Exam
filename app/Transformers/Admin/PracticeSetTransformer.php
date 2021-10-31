<?php
/**
 * File name: PracticeSetTransformer.php
 * Last modified: 17/06/21, 4:10 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Transformers\Admin;

use App\Models\PracticeSet;
use League\Fractal\TransformerAbstract;

class PracticeSetTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param PracticeSet $practiceSet
     * @return array
     */
    public function transform(PracticeSet $practiceSet)
    {
        return [
            'id' => $practiceSet->id,
            'title' => $practiceSet->title,
            'code' => $practiceSet->code,
            'slug' => $practiceSet->slug,
            'questions' => $practiceSet->total_questions.' Questions',
            'subCategory' => $practiceSet->subCategory->name,
            'skill' => $practiceSet->skill->name,
            'status' => $practiceSet->is_active,
        ];
    }
}

