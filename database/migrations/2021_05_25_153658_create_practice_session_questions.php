<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePracticeSessionQuestions extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('practice_session_questions', function (Blueprint $table) {
            $table->unsignedBigInteger('practice_session_id');
            $table->unsignedBigInteger('question_id');
            $table->text('original_question');
            $table->text('options')->nullable();
            $table->text('user_answer')->nullable();
            $table->text('correct_answer')->nullable();
            $table->string('status')->default('unanswered');
            $table->boolean('is_correct')->nullable();
            $table->integer('time_taken')->default(0);
            $table->unsignedInteger('points_earned')->default(0);

            $table->primary(['practice_session_id', 'question_id'], 'practice_session_questions_primary');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('practice_session_questions');
    }
}
