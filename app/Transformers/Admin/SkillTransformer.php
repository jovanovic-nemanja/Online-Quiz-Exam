<?php
/**
 * File name: SkillTransformer.php
 * Last modified: 11/05/21, 10:50 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Transformers\Admin;

use App\Models\Skill;
use League\Fractal\TransformerAbstract;

class SkillTransformer extends TransformerAbstract
{
    public function transform(Skill $skill)
    {
        return [
            'id' => $skill->id,
            'name' => $skill->name,
            'code' => $skill->code,
            'section' => $skill->section->name,
            'status' => $skill->is_active,
        ];
    }
}
