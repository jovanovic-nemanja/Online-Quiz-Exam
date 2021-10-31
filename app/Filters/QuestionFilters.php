<?php
/**
 * File name: QuestionFilters.php
 * Last modified: 14/07/21, 4:04 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Filters;


class QuestionFilters extends QueryFilter
{
    /*
    |--------------------------------------------------------------------------
    | DEFINE ALL COLUMN FILTERS BELOW
    |--------------------------------------------------------------------------
    */

    public function code($query = "")
    {
        return $this->builder->where('code', 'like', '%'.$query.'%');
    }

    public function question($query = "")
    {
        return $this->builder->where('question', 'like', '%'.$query.'%');
    }

    public function questionType($query = 0)
    {
        return $this->builder->where('question_type_id', $query);
    }

    public function section($query = '')
    {
        if($query !== '') {
            return $this->builder->whereHas('section', function ($q) use ($query) {
                $q->where('sections.name', 'like', "%{$query}%");
            });
        }
        return null;
    }

    public function skill($query = '')
    {
        if($query !== '') {
            return $this->builder->whereHas('skill', function ($q) use ($query) {
                $q->where('name', 'like', "%{$query}%");
            });
        }
        return null;
    }

    public function topic($query = '')
    {
        if($query !== '') {
            return $this->builder->whereHas('topic', function ($q) use ($query) {
                $q->where('name', 'like', "%{$query}%");
            });
        }
        return null;
    }

    public function status($query = 0)
    {
        return $this->builder->where('is_active', $query);
    }

    public function difficulty_levels($query = [])
    {
        return $this->builder->whereIn('difficulty_level_id', $query);
    }

    public function question_types($query = [])
    {
        return $this->builder->whereIn('question_type_id', $query);
    }
}
