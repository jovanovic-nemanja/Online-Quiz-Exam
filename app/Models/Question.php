<?php
/**
 * File name: Question.php
 * Last modified: 16/07/21, 9:44 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Models;

use App\Filters\QueryFilter;
use App\Traits\SecureDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Str;
use Znck\Eloquent\Traits\BelongsToThrough;

class Question extends Model
{
    use HasFactory;
    use SoftDeletes;
    use SecureDeletes;
    use BelongsToThrough;

    /*
    |--------------------------------------------------------------------------
    | GLOBAL VARIABLES
    |--------------------------------------------------------------------------
    */

    protected $guarded = [];

    protected $casts = [
        'options' => 'array',
        'preferences' => 'object',
        'has_attachment' => 'boolean',
        'attachment_options' => 'object',
        'solution_video' => 'object',
        'is_active' => 'boolean',
    ];

    /*
    |--------------------------------------------------------------------------
    | FUNCTIONS
    |--------------------------------------------------------------------------
    */

    protected static function booted()
    {
        static::creating(function ($category) {
            $category->attributes['code'] = 'que_'.Str::random(11);
        });
    }

    /*
    |--------------------------------------------------------------------------
    | RELATIONS
    |--------------------------------------------------------------------------
    */

    public function questionType()
    {
        return $this->belongsTo(QuestionType::class);
    }

    public function topic()
    {
        return $this->belongsTo(Topic::class);
    }

    public function skill()
    {
        return $this->belongsTo(Skill::class);
    }

    public function section()
    {
        return $this->belongsToThrough(Section::class, Skill::class);
    }

    public function difficultyLevel()
    {
        return $this->belongsTo(DifficultyLevel::class);
    }

    public function comprehensionPassage()
    {
        return $this->belongsTo(ComprehensionPassage::class);
    }

    public function practiceSets()
    {
        return $this->belongsToMany(PracticeSet::class, 'practice_set_questions', 'question_id', 'practice_set_id');
    }

    public function practiceSessions()
    {
        return $this->belongsToMany(PracticeSession::class, 'practice_session_questions')
            ->withPivot('status', 'original_question', 'is_correct', 'time_taken', 'options', 'user_answer', 'correct_answer', 'points_earned');
    }

    public function quizzes()
    {
        return $this->belongsToMany(Quiz::class, 'quiz_questions', 'question_id', 'quiz_id');
    }

    public function quizSessions()
    {
        return $this->belongsToMany(QuizSession::class, 'quiz_session_questions')
            ->withPivot('status', 'original_question', 'options', 'is_correct', 'time_taken', 'user_answer', 'correct_answer', 'marks_earned', 'marks_deducted');
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

    public function getCorrectAnswerAttribute($value)
    {
        return unserialize($value);
    }

    /*
    |--------------------------------------------------------------------------
    | MUTATORS
    |--------------------------------------------------------------------------
    */

    public function setCorrectAnswerAttribute($value)
    {
        $this->attributes['correct_answer'] = serialize($value);
    }

}
