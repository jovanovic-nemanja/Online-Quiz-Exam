<?php
/**
 * File name: CategoryTransformer.php
 * Last modified: 01/02/21, 5:16 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Transformers\Admin;

use App\Models\Category;
use League\Fractal\TransformerAbstract;

class CategoryTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param Category $category
     * @return array
     */
    public function transform(Category $category)
    {
        return [
            'id' => $category->id,
            'name' => $category->name,
            'code' => $category->code,
            'short_description' => $category->short_description,
            'description' => $category->description,
            'image_path' => $category->image_path,
            'status' => $category->is_active ? 'Active' : 'In-active',
        ];
    }
}
