<?php
/**
 * File name: QuizScheduleFilters.php
 * Last modified: 17/06/21, 3:55 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Filters;


class QuizScheduleFilters extends QueryFilter
{
    /*
    |--------------------------------------------------------------------------
    | DEFINE ALL COLUMN FILTERS BELOW
    |--------------------------------------------------------------------------
    */

    public function status($query = "")
    {
        return $this->builder->where('status', $query);
    }
}
