<?php
/**
 * File name: Quiz.php
 * Last modified: 11/07/21, 10:22 PM
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
use Illuminate\Database\Eloquent\Builder;
use Spatie\SchemalessAttributes\SchemalessAttributesTrait;

class Quiz extends Model
{
    use HasFactory;
    use Sluggable;
    use SchemalessAttributesTrait;
    use SoftDeletes;
    use SecureDeletes;

    /*
    |--------------------------------------------------------------------------
    | GLOBAL VARIABLES
    |--------------------------------------------------------------------------
    */

    protected $table = 'quizzes';

    protected $guarded = [];

    protected $casts = [
        'is_paid' => 'boolean',
        'is_private' => 'boolean',
        'is_active' => 'boolean',
        'can_redeem' => 'boolean'
    ];

    protected $schemalessAttributes = [
        'settings',
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
                'source' => 'title'
            ]
        ];
    }

    protected static function booted()
    {
        static::creating(function ($quiz) {
            $quiz->attributes['code'] = 'quiz_'.Str::random(11);
        });
    }

    public function updateMeta()
    {
        $this->total_questions = $this->questions()->count();

        if ($this->settings->get('auto_duration', true)) {
            $this->total_duration = $this->questions()->sum('default_time');
        }

        if ($this->settings->get('auto_grading', true)) {
            $this->total_marks = $this->questions()->sum('default_marks');
        } else {
            $this->total_marks = $this->questions()->count() * $this->settings->get('correct_marks');
        }

        $this->update();
    }

    /*
    |--------------------------------------------------------------------------
    | RELATIONS
    |--------------------------------------------------------------------------
    */

    public function subCategory()
    {
        return $this->belongsTo(SubCategory::class);
    }

    public function quizType()
    {
        return $this->belongsTo(QuizType::class);
    }

    public function questions()
    {
        return $this->belongsToMany(Question::class, 'quiz_questions', 'quiz_id', 'question_id');
    }

    public function sessions()
    {
        return $this->hasMany(QuizSession::class);
    }

    public function quizSchedules()
    {
        return $this->hasMany(QuizSchedule::class);
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

    public function scopeWithSettings(): Builder
    {
        return $this->settings->modelCast();
    }

    public function scopePublished($query)
    {
        $query->where('is_active', true);
    }

    public function scopeIsPublic($query)
    {
        $query->where('is_private', false);
    }

    public function scopeIsPrivate($query)
    {
        $query->where('is_private', true);
    }

    /*
    |--------------------------------------------------------------------------
    | ACCESSORS
    |--------------------------------------------------------------------------
    */

    public function getPriceAttribute($value)
    {
        return $value / 100;
    }

    /*
    |--------------------------------------------------------------------------
    | MUTATORS
    |--------------------------------------------------------------------------
    */

    public function setPriceAttribute($value)
    {
        $this->attributes['price'] = $value * 100;
    }

}
