<?php
/**
 * File name: SkillSearchTransformer.php
 * Last modified: 13/03/21, 4:04 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Transformers\Admin;

use App\Models\Skill;
use League\Fractal\TransformerAbstract;

class SkillSearchTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param Skill $skill
     * @return array
     */
    public function transform(Skill $skill)
    {
        return [
            'id' => $skill->id,
            'name' => $skill->name.' ('.$skill->section->name.')'
        ];
    }
}
