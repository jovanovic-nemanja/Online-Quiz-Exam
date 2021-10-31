<?php
/**
 * File name: ExamFilters.php
 * Last modified: 14/05/21, 3:37 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Filters;


class ExamFilters extends QueryFilter
{
    /*
    |--------------------------------------------------------------------------
    | DEFINE ALL COLUMN FILTERS BELOW
    |--------------------------------------------------------------------------
    */

    public function title($query = "")
    {
        return $this->builder->where('title', 'like', '%'.$query.'%');
    }

    public function code($query = "")
    {
        return $this->builder->where('code', 'like', '%'.$query.'%');
    }

    public function status($query = 0)
    {
        return $this->builder->where('is_active', $query);
    }
}
