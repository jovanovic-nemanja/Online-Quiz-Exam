<?php
/**
 * File name: SkillFilters.php
 * Last modified: 12/05/21, 4:19 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Filters;

class SkillFilters extends QueryFilter
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

    public function code($query)
    {
        return $this->builder->where('code', 'like', '%'.$query.'%');
    }

    function section_id($query)
    {
        return $this->builder->where('section_id', $query);
    }

    public function status($query = 0)
    {
        return $this->builder->where('is_active', $query);
    }
}
