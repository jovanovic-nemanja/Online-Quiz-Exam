<?php
/**
 * File name: UserFilters.php
 * Last modified: 01/02/21, 12:19 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Filters;


class UserFilters extends QueryFilter
{
    /*
    |--------------------------------------------------------------------------
    | DEFINE ALL COLUMN FILTERS BELOW
    |--------------------------------------------------------------------------
    */

    public function fullName($query = "")
    {
        return $this->builder->where('first_name', 'like', '%'.$query.'%')
            ->orWhere('last_name', 'like', '%'.$query.'%');
    }

    public function firstName($query = "")
    {
        return $this->builder->where('first_name', 'like', '%'.$query.'%');
    }

    public function lastName($query = "")
    {
        return $this->builder->where('last_name', 'like', '%'.$query.'%');
    }

    public function userName($query = "")
    {
        return $this->builder->where('user_name', 'like', '%'.$query.'%');
    }

    public function email($query = "")
    {
        return $this->builder->where('email', $query);
    }

    public function role($query = "")
    {
        return $this->builder->role($query);
    }

    public function status($status = 0)
    {
        return $this->builder->where('is_active', $status);
    }
}
