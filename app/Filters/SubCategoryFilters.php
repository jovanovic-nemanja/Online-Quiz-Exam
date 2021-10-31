<?php
/**
 * File name: SubCategoryFilters.php
 * Last modified: 01/02/21, 6:42 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Filters;


class SubCategoryFilters extends QueryFilter
{
    /*
    |--------------------------------------------------------------------------
    | DEFINE ALL COLUMN FILTERS BELOW
    |--------------------------------------------------------------------------
    */

    public function name($query = "")
    {
        return $this->builder->where('name', 'like', '%'.$query.'%');
    }

    public function code($query = "")
    {
        return $this->builder->where('code', 'like', '%'.$query.'%');
    }

    public function is_active($query = 0)
    {
        return $this->builder->where('is_active', $query);
    }
}
