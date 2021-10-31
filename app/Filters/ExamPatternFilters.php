<?php
/**
 * File name: ExamPatternFilters.php
 * Last modified: 06/05/21, 2:43 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Filters;


class ExamPatternFilters extends QueryFilter
{
    /*
    |--------------------------------------------------------------------------
    | DEFINE ALL COLUMN FILTERS BELOW
    |--------------------------------------------------------------------------
    */

    public function name($query)
    {
        return $this->builder->where('name', 'like', '%'.$query.'%');
    }

    public function is_active($query)
    {
        return $this->builder->where('is_active', $query);
    }
}
