<?php
/**
 * File name: UserGroupTransformer.php
 * Last modified: 21/06/21, 10:50 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Transformers\Admin;

use App\Models\UserGroup;
use League\Fractal\TransformerAbstract;

class UserGroupTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param UserGroup $userGroup
     * @return array
     */
    public function transform(UserGroup $userGroup)
    {
        return [
            'id' => $userGroup->id,
            'code' => $userGroup->code,
            'name' => $userGroup->name,
            'description' => $userGroup->description,
            'visibility' => $userGroup->is_private ? 'Private Group' : 'Public Group',
            'status' => $userGroup->is_active,
        ];
    }
}
