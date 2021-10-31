<?php
/**
 * File name: instructor.php
 * Last modified: 12/07/21, 5:02 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

use App\Http\Controllers\Instructor\DashboardController;

Route::middleware(['auth:sanctum', 'verified'])->prefix('instructor')->group(function () {
    Route::get('/dashboard', [DashboardController::class, 'index'])->name('instructor_dashboard');
});
