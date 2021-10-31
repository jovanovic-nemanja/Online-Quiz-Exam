<?php
/**
 * File name: SubCategory.php
 * Last modified: 07/07/21, 10:38 PM
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

class SubCategory extends Model
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

    protected $table = 'sub_categories';

    protected $guarded = [];

    protected $casts = [
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
        static::creating(function ($subCategory) {
            $subCategory->attributes['code'] = 'sub_'.Str::random(11);
        });
    }

    /*
    |--------------------------------------------------------------------------
    | RELATIONS
    |--------------------------------------------------------------------------
    */

    public function subCategoryType()
    {
        return $this->belongsTo(SubCategoryType::class);
    }

    public function category()
    {
        return $this->belongsTo(Category::class);
    }

    public function sections()
    {
        return $this->belongsToMany(Section::class, 'sub_category_sections', 'sub_category_id', 'section_id');
    }

    public function practiceSets()
    {
        return $this->belongsTo(PracticeSet::class);
    }

    public function quizzes()
    {
        return $this->belongsTo(Quiz::class);
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
        return $query->where('is_active', 1);
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
