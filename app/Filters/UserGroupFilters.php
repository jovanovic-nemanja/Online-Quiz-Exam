<?php
/**
 * File name: UserGroupFilters.php
 * Last modified: 29/01/21, 12:35 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Filters;


class UserGroupFilters extends QueryFilter
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

    public function visibility($visibility = 0)
    {
        return $this->builder->where('is_private', $visibility);
    }

    public function status($status = 0)
    {
        return $this->builder->where('is_active', $status);
    }
}
