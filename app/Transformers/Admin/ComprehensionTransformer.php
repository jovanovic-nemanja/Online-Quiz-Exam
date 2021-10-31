<?php
/**
 * File name: ComprehensionTransformer.php
 * Last modified: 17/03/21, 9:32 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Transformers\Admin;

use App\Models\ComprehensionPassage;
use Illuminate\Support\Str;
use League\Fractal\TransformerAbstract;

class ComprehensionTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param ComprehensionPassage $passage
     * @return array
     */
    public function transform(ComprehensionPassage $passage)
    {
        return [
            'id' => $passage->id,
            'title' => $passage->title,
            'body' => Str::limit($passage->body, 100),
            'code' => $passage->code,
            'status' => $passage->is_active ? 'Active' : 'In-active',
        ];
    }
}
