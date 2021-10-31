<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateQuizSessionQuestionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('quiz_session_questions', function (Blueprint $table) {
            $table->unsignedBigInteger('quiz_session_id');
            $table->unsignedBigInteger('question_id');
            $table->text('original_question');
            $table->text('options')->nullable();
            $table->text('user_answer')->nullable();
            $table->text('correct_answer')->nullable();
            $table->string('status')->default('unanswered');
            $table->boolean('is_correct')->nullable();
            $table->integer('time_taken')->default(0);
            $table->double('marks_earned', 5, 2)->default(0);
            $table->double('marks_deducted', 5, 2)->default(0);

            $table->primary(['quiz_session_id', 'question_id'], 'quiz_session_questions_primary');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('quiz_session_questions');
    }
}
