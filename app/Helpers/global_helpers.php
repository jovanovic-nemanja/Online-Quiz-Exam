<?php
/**
 * File name: global_helpers.php
 * Last modified: 14/06/21, 7:36 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

if (!function_exists('formattedSeconds')) {
    /**
     * Seconds to Human Readable Time Format
     * @param $seconds
     * @return array
     */
    function formattedSeconds($seconds)
    {
        $hours = floor($seconds / 3600);
        $minutes = floor(($seconds / 60) % 60);
        $sec = $seconds % 60;
        return [
            'seconds' => $seconds,
            'short_readable' => "$hours:$minutes:$sec",
            'detailed_readable' => $hours > 0 ? "$hours Hrs $minutes Min" : ($minutes > 0 ? "$minutes Min $sec Sec" : "$sec Sec")
        ];
    }
}

if (!function_exists('calculateSpeedPerHour')) {
    /**
     * Calculate questions speed per hour
     * @param $totalAnswered
     * @param $totalSeconds
     * @return float|int
     */
    function calculateSpeedPerHour($totalAnswered, $totalSeconds)
    {
        return $totalAnswered !== 0 ? ($totalAnswered * 3600) / $totalSeconds : 0;
    }
}

if (!function_exists('calculateAccuracy')) {
    /**
     * Calculate accuracy of a test
     * @param $correctAnswered
     * @param $totalAnswered
     * @return float|int
     */
    function calculateAccuracy($correctAnswered, $totalAnswered)
    {
        return $totalAnswered != 0 ? ($correctAnswered / $totalAnswered) * 100 : 0;
    }
}

if (!function_exists('calculatePercentage')) {
    /**
     * Calculate percentage
     * @param $x
     * @param $y
     * @return float|int
     */
    function calculatePercentage($x, $y)
    {
        return $y != 0 ? $x / $y * 100 : 0;
    }
}

if (!function_exists('calculatePercentileRank')) {
    /**
     * Calculate percentile
     * @param $array
     * @param $key
     * @return float|int
     */
    function calculatePercentileRank($array, $key)
    {
        $n = count($array);
        $l = binarySearchCount($array, $n, $key);
        return round(($l / $n) * 100, 0); // Percentile Rank Formula
    }
}

if (!function_exists('binarySearchCount')) {
    /**
     * A binary search function to return number of elements less than or equal to given key
     *
     * @param $arr
     * @param $n
     * @param $key
     * @return float|int
     */
    function binarySearchCount($arr, $n, $key)
    {
        $left = 0;
        $right = $n - 1;

        $count = 0;

        while ($left <= $right) {
            $mid = round(($right + $left) / 2, 0);
            // Check if middle element is less than or equal to key
            if ($arr[$mid] <= $key) {
                ; // At least (mid + 1) elements are there whose values are less than or equal to key
                $count = $mid+1;
                $left = $mid + 1;
            } // If key is smaller, ignore right half
            else
                $right = $mid - 1;
        }
        return $count;
    }
}
