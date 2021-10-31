<?php
/**
 * File name: PracticeSetCardTransformer.php
 * Last modified: 22/05/21, 12:09 AM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Transformers\Platform;

use App\Models\PracticeSet;
use League\Fractal\TransformerAbstract;

class PracticeSetCardTransformer extends TransformerAbstract
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
            'slug' => $practiceSet->slug,
            'total_questions' => $practiceSet->total_questions,
            'skill' => $practiceSet->skill->name,
        ];
    }
}
