<?php
/**
 * File name: ExamScheduleFilters.php
 * Last modified: 14/05/21, 1:37 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Filters;


class ExamScheduleFilters extends QueryFilter
{
    /*
    |--------------------------------------------------------------------------
    | DEFINE ALL COLUMN FILTERS BELOW
    |--------------------------------------------------------------------------
    */

    function status($query)
    {
        return $this->builder->where('status', $query);
    }
}
