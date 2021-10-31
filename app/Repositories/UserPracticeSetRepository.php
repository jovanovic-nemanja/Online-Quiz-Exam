<?php
/**
 * File name: UserPracticeSetRepository.php
 * Last modified: 17/07/21, 11:58 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Repositories;

use App\Models\PracticeSession;
use App\Models\PracticeSet;
use Jenssegers\Agent\Agent;

class UserPracticeSetRepository
{
    /**
     * Get existing practice session of a user, if any
     *
     * @param PracticeSet $set
     * @return \Illuminate\Database\Eloquent\Model|\Illuminate\Database\Eloquent\Relations\HasMany|object|null
     */
    public function getSession(PracticeSet $set)
    {
        return $set->sessions()->where('user_id', auth()->user()->id)->latest()->first();
    }

    /**
     * Create a new practice session for an user
     *
     * @param PracticeSet $set
     * @return |null
     */
    public function createSession(PracticeSet $set)
    {
        $session = PracticeSession::create([
            'practice_set_id' => $set->id,
            'user_id' => auth()->user()->id,
            'status' => 'started'
        ]);

        if($session) {
            return $session;
        }

        return null;
    }

    /**
     * Generate user practice session analytics
     *
     * @param $session
     * @param $total
     * @return array
     */
    public function sessionAnalytics($session, $total)
    {
        $questions = collect($session->questions);
        $answered = $questions->where('pivot.status', '=', 'answered')->count();
        $correct = $questions->where('pivot.is_correct', '=', true)->count();
        $wrong = $questions->where('pivot.is_correct', '=', false)->count();
        $answered_time = $questions->where('pivot.status', '=', 'answered')->sum('pivot.time_taken');
        $agent = new Agent();
        return [
            'speed' => round(calculateSpeedPerHour($answered, $session->total_time_taken)),
            'accuracy' => round(calculateAccuracy($correct, $answered), 2),
            'total_questions' => $total,
            'answered_questions' => $answered,
            'unanswered_questions' => $total - $answered,
            'correct_answered_questions' => $correct,
            'wrong_answered_questions' => $wrong,
            'total_time_taken' => formattedSeconds($session->total_time_taken),
            'time_taken_for_answered' => formattedSeconds($answered_time),
            'time_taken_for_other' => formattedSeconds($session->total_time_taken - $answered_time),
            'time_taken_for_correct_answered' => formattedSeconds($questions->where('pivot.is_correct', '=', true)->sum('pivot.time_taken')),
            'time_taken_for_wrong_answered' => formattedSeconds($questions->where('pivot.is_correct', '=', false)->sum('pivot.time_taken')),
            'user_agent' => $agent->getUserAgent(),
            'ip_address' => request()->getClientIp()
        ];
    }
}
