<?php
/**
 * File name: TopicFilters.php
 * Last modified: 11/05/21, 4:10 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Filters;

class TopicFilters extends QueryFilter
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

    function skill_id($query)
    {
        return $this->builder->where('skill_id', $query);
    }

    public function is_active($query)
    {
        return $this->builder->where('is_active', $query);
    }
}
