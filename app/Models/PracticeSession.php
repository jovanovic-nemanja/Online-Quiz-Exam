<?php
/**
 * File name: PracticeSession.php
 * Last modified: 16/07/21, 11:42 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Models;

use App\Traits\SecureDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Str;
use Spatie\SchemalessAttributes\SchemalessAttributesTrait;

class PracticeSession extends Model
{
    use HasFactory;
    use SchemalessAttributesTrait;
    use SoftDeletes;
    use SecureDeletes;

    /*
    |--------------------------------------------------------------------------
    | GLOBAL VARIABLES
    |--------------------------------------------------------------------------
    */

    protected $guarded = [];

    protected $casts = [
        'completed_at' => 'datetime',
    ];

    protected $schemalessAttributes = [
        'results',
    ];

    /*
    |--------------------------------------------------------------------------
    | FUNCTIONS
    |--------------------------------------------------------------------------
    */

    protected static function booted()
    {
        static::creating(function ($category) {
            $category->attributes['code'] = Str::uuid();
        });
    }

    /*
    |--------------------------------------------------------------------------
    | RELATIONS
    |--------------------------------------------------------------------------
    */

    public function practiceSet()
    {
        return $this->belongsTo(PracticeSet::class, 'practice_set_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function questions()
    {
        return $this->belongsToMany(Question::class, 'practice_session_questions')
            ->withPivot('status', 'is_correct', 'time_taken', 'original_question', 'options', 'user_answer', 'correct_answer', 'points_earned');
    }

    /*
    |--------------------------------------------------------------------------
    | SCOPES
    |--------------------------------------------------------------------------
    */

    public function scopePending($query)
    {
        return $query->where('status', '=', 'started');
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
