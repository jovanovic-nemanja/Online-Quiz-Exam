<?php
/**
 * File name: TopicTransformer.php
 * Last modified: 11/05/21, 11:10 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Transformers\Admin;

use App\Models\Topic;
use League\Fractal\TransformerAbstract;

class TopicTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param Topic $topic
     * @return array
     */
    public function transform(Topic $topic)
    {
        return [
            'id' => $topic->id,
            'code' => $topic->code,
            'name' => $topic->name,
            'skill' => $topic->skill->name,
            'status' => $topic->is_active,
        ];
    }
}
