<?php
/**
 * File name: DatabaseSeeder.php
 * Last modified: 18/07/21, 11:08 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace Database\Seeders;

use App\Models\User;
use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Spatie\Permission\Models\Role;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        // Create Roles
        $roles = ['admin', 'instructor', 'student', 'parent', 'guest', 'employee', 'institute', 'candidate'];

        foreach($roles as $role) {
            Role::create(['name' => $role]);
        }

        // Create user and assign admin role
        $user = User::create([
            'first_name' => 'QwikTest',
            'last_name' => 'Admin',
            'user_name' => 'admin',
            'email' => 'admin@qwiktest.com',
            'password' => Hash::make('password'),
            'email_verified_at' => Carbon::now()->toDateTimeString()
        ]);

        $user->assignRole('admin');

        DB::table('question_types')->insert([
            ['name' => 'Multiple Choice Single Answer', 'code' => 'MSA', 'type' => 'objective', 'icon_path' => 'msa.png', 'short_description' => 'This question type is easy to set up and is the most frequent MCQ question in online exams. Users are allowed to pick just one answer from a list of given options.', 'is_active' => 1],
            ['name' => 'Multiple Choice Multiple Answers', 'code' => 'MMA', 'type' => 'objective', 'icon_path' => 'mma.png', 'short_description' => 'Multiple Choice Multiple Answers type question allows users to select one or several answers from a list of given options.', 'is_active' => 1],
            ['name' => 'True or False', 'code' => 'TOF', 'type' => 'objective', 'icon_path' => 'tof.png', 'short_description' => 'A true or false question consists of a statement that requires a true or false response. We can also format the options such as: Yes/No, Correct/Incorrect, and Agree/Disagree.', 'is_active' => 1],
            ['name' => 'Short Answer', 'code' => 'SAQ', 'type' => 'objective', 'icon_path' => 'saq.png', 'short_description' => 'Short answer questions allow users to provide text or numeric answers. These responses will be validated against the provided possible answers.', 'is_active' => 1],
            ['name' => 'Match the Following', 'code' => 'MTF', 'type' => 'objective', 'icon_path' => 'mtf.png', 'short_description' => 'A matching question is two adjacent lists of related words, phrases, pictures, or symbols. Each item in one list is paired with at least one item in the other list.', 'is_active' => 1],
            ['name' => 'Ordering/Sequence', 'code' => 'ORD', 'type' => 'objective', 'icon_path' => 'ord.png', 'short_description' => 'An ordering/sequence question consists of a scrambled list of related words, phrases, pictures, or symbols. The User needs to arrange them in a logical order/sequence.', 'is_active' => 1],
            ['name' => 'Fill in the Blanks', 'code' => 'FIB', 'type' => 'objective', 'icon_path' => 'fib.png', 'short_description' => 'A Fill in the Blank question consists of a phrase, sentence, or paragraph with a blank space where a student provides the missing word or words.', 'is_active' => 1],
            ['name' => 'Long Answer/Paragraph', 'code' => 'LAQ', 'type' => 'subjective', 'icon_path' => 'laq.png', 'short_description' => 'In Long answer or paragraph question type is equivalent to essay writing where a student provides a text box to write his response.', 'is_active' => 0],
        ]);

        // Create difficulty levels
        DB::table('difficulty_levels')->insert([
            ['name' => 'Very Easy', 'code' => 'VERYEASY', 'is_active' => 1],
            ['name' => 'Easy', 'code' => 'EASY', 'is_active' => 1],
            ['name' => 'Medium', 'code' => 'MEDIUM', 'is_active' => 1],
            ['name' => 'High', 'code' => 'HIGH', 'is_active' => 1],
            ['name' => 'Very High', 'code' => 'VERYHIGH', 'is_active' => 1],
        ]);

        // Create Quiz Types
        DB::table('quiz_types')->insert([
            ['name' => 'Quiz', 'code' => 'qtp_lLvoMjFoKRf', 'slug' => 'quiz', 'is_active' => 1],
            ['name' => 'Contest', 'code' => 'qtp_uqQvsmXRube', 'slug' => 'contest', 'is_active' => 1],
            ['name' => 'Daily Challenge', 'code' => 'qtp_xJnjmbmgV5E', 'slug' => 'daily-challenge', 'is_active' => 1],
            ['name' => 'Daily Task', 'code' => 'qtp_dJ7t7b2onxc', 'slug' => 'daily-task', 'is_active' => 1],
            ['name' => 'Hackathon', 'code' => 'qtp_pALr8tBpML7', 'slug' => 'hackathon', 'is_active' => 1],
            ['name' => 'Assignment', 'code' => 'qtp_ok3cIEqIHg4', 'slug' => 'assignment', 'is_active' => 1],
        ]);

        // Create Sub Category Types
        DB::table('sub_category_types')->insert([
            ['name' => 'Course', 'code' => 'course', 'is_active' => 1],
            ['name' => 'Certification', 'code' => 'certification', 'is_active' => 1],
            ['name' => 'Class', 'code' => 'class', 'is_active' => 1],
            ['name' => 'Exam', 'code' => 'exam', 'is_active' => 1],
            ['name' => 'Grade', 'code' => 'grade', 'is_active' => 1],
            ['name' => 'Standard', 'code' => 'standard', 'is_active' => 1],
            ['name' => 'Stream', 'code' => 'stream', 'is_active' => 1],
            ['name' => 'Level', 'code' => 'level', 'is_active' => 1],
            ['name' => 'Skill', 'code' => 'skill', 'is_active' => 1],
            ['name' => 'Branch', 'code' => 'branch', 'is_active' => 1],
        ]);
    }
}
