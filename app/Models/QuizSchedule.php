<?php
/**
 * File name: QuizSchedule.php
 * Last modified: 19/07/21, 11:25 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Models;

use App\Filters\QueryFilter;
use App\Settings\LocalizationSettings;
use App\Traits\SecureDeletes;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Str;

class QuizSchedule extends Model
{
    use HasFactory;
    use SoftDeletes;
    use SecureDeletes;

    /*
    |--------------------------------------------------------------------------
    | GLOBAL VARIABLES
    |--------------------------------------------------------------------------
    */

    protected $table = 'quiz_schedules';
    protected $guarded = [];

    /*
    |--------------------------------------------------------------------------
    | FUNCTIONS
    |--------------------------------------------------------------------------
    */

    protected static function booted()
    {
        static::creating(function ($examSchedule) {
            $examSchedule->attributes['code'] = 'qsd_'.Str::random(11);
        });
    }

    /*
    |--------------------------------------------------------------------------
    | RELATIONS
    |--------------------------------------------------------------------------
    */

    public function quiz()
    {
        return $this->belongsTo(Quiz::class);
    }

    public function userGroups()
    {
        return $this->belongsToMany(UserGroup::class, 'user_group_quiz_schedules', 'quiz_schedule_id', 'user_group_id');
    }

    public function sessions()
    {
        return $this->hasMany(QuizSession::class);
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
        return $query->where('status', '=', 'active');
    }

    /*
    |--------------------------------------------------------------------------
    | ACCESSORS
    |--------------------------------------------------------------------------
    */

    public function getStartsAtAttribute()
    {
        $localization = app(LocalizationSettings::class);
        return Carbon::createFromFormat('Y-m-d H:i:s', $this->start_date.' '.$this->start_time, $localization->default_timezone);
    }

    public function getEndsAtAttribute()
    {
        $localization = app(LocalizationSettings::class);
        return Carbon::createFromFormat('Y-m-d H:i:s', $this->end_date.' '.$this->end_time, $localization->default_timezone);
    }

    public function getStartsAtFormattedAttribute()
    {
        $localization = app(LocalizationSettings::class);

        if($this->schedule_type == 'fixed') {
            return Carbon::createFromFormat('Y-m-d H:i:s', $this->start_date.' '.$this->start_time, $localization->default_timezone)
                ->format('D, M jS, Y');
        } else {
            return Carbon::createFromFormat('Y-m-d H:i:s', $this->start_date.' '.$this->start_time, $localization->default_timezone)
                ->format('D, M jS, Y, h:i A');
        }
    }

    public function getEndsAtFormattedAttribute()
    {
        $localization = app(LocalizationSettings::class);

        if($this->schedule_type == 'fixed') {
            $sd = Carbon::createFromFormat('Y-m-d H:i:s', $this->start_date.' '.$this->start_time, $localization->default_timezone);
            $ed = Carbon::createFromFormat('Y-m-d H:i:s', $this->end_date.' '.$this->end_time, $localization->default_timezone);
            return $sd->format('h:i A').' - '.$ed->format('h:i A');
        } else {
            return Carbon::createFromFormat('Y-m-d H:i:s', $this->end_date.' '.$this->end_time, $localization->default_timezone)
                ->format('D, M jS, Y, h:i A');
        }
    }

    public function getTimezoneAttribute()
    {
        return app(LocalizationSettings::class)->default_timezone;
    }


    /*
    |--------------------------------------------------------------------------
    | MUTATORS
    |--------------------------------------------------------------------------
    */
}
