<?php
/**
 * File name: TopicSearchTransformer.php
 * Last modified: 13/03/21, 4:11 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Transformers\Admin;

use App\Models\Topic;
use League\Fractal\TransformerAbstract;

class TopicSearchTransformer extends TransformerAbstract
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
            'name' => $topic->name.' ('.$topic->skill->name.')'
        ];
    }
}
