<?php
/**
 * File name: QuizFilters.php
 * Last modified: 17/06/21, 5:58 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Filters;


class QuizFilters extends QueryFilter
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

    public function visibility($query = 0)
    {
        return $this->builder->where('is_private', $query);
    }

    public function status($query = 0)
    {
        return $this->builder->where('is_active', $query);
    }
}
