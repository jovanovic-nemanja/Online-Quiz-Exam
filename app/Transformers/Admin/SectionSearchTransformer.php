<?php
/**
 * File name: SectionSearchTransformer.php
 * Last modified: 06/04/21, 3:52 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Transformers\Admin;

use App\Models\Section;
use League\Fractal\TransformerAbstract;

class SectionSearchTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param Section $section
     * @return array
     */
    public function transform(Section $section)
    {
        return [
            'id' => $section->id,
            'name' => $section->name
        ];
    }
}
