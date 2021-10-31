<?php
/**
 * File name: UserGroup.php
 * Last modified: 21/06/21, 4:53 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Models;

use App\Filters\QueryFilter;
use App\Traits\SecureDeletes;
use Cviebrock\EloquentSluggable\Sluggable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Str;

class UserGroup extends Model
{
    use HasFactory;
    use Sluggable;
    use SoftDeletes;
    use SecureDeletes;

    /*
    |--------------------------------------------------------------------------
    | GLOBAL VARIABLES
    |--------------------------------------------------------------------------
    */

    protected $guarded = [];

    public $casts = [
        'settings' => 'array',
        'is_private' => 'boolean',
        'is_active' => 'boolean'
    ];

    /*
    |--------------------------------------------------------------------------
    | FUNCTIONS
    |--------------------------------------------------------------------------
    */

    public function sluggable(): array
    {
        return [
            'slug' => [
                'source' => 'name'
            ]
        ];
    }

    protected static function booted()
    {
        static::creating(function ($category) {
            $category->attributes['code'] = 'ugp_'.Str::random(11);
        });
    }

    /*
    |--------------------------------------------------------------------------
    | RELATIONS
    |--------------------------------------------------------------------------
    */

    public function users()
    {
        return $this->belongsToMany(User::class, 'user_group_users', 'user_group_id', 'user_id')
            ->withPivot('joined_at');
    }

    public function quizSchedules()
    {
        return $this->belongsToMany(QuizSchedule::class, 'user_group_quiz_schedules', 'user_group_id', 'quiz_schedule_id');
    }

    /*
    |--------------------------------------------------------------------------
    | SCOPES
    |--------------------------------------------------------------------------
    */

    public function scopeFilter($query, QueryFilter $filters)
    {
        return $filters->apply($query);
    }

    public function scopeActive($query)
    {
        $query->where('is_active', true);
    }

    /*
    |--------------------------------------------------------------------------
    | ACCESSORS
    |--------------------------------------------------------------------------
    */

    /*
    |--------------------------------------------------------------------------
    | MUTATORS
    |--------------------------------------------------------------------------
    */

}
