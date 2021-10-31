<?php
/**
 * File name: SectionTransformer.php
 * Last modified: 11/05/21, 5:48 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Transformers\Admin;

use App\Models\Section;
use League\Fractal\TransformerAbstract;

class SectionTransformer extends TransformerAbstract
{
    public function transform(Section $section)
    {
        return [
            'id' => $section->id,
            'name' => $section->name,
            'code' => $section->code,
            'icon_path' => $section->icon_path,
            'status' => $section->is_active,
        ];
    }
}

