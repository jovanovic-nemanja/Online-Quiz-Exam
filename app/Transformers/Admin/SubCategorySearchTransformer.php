<?php
/**
 * File name: SubCategorySearchTransformer.php
 * Last modified: 22/03/21, 7:58 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Transformers\Admin;

use App\Models\SubCategory;
use League\Fractal\TransformerAbstract;

class SubCategorySearchTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param SubCategory $subCategory
     * @return array
     */
    public function transform(SubCategory $subCategory)
    {
        return [
            'id' => $subCategory->id,
            'name' => $subCategory->name.' ('.$subCategory->category->name.')'
        ];
    }
}
