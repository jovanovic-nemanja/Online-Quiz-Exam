<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateQuestionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('questions', function (Blueprint $table) {
            $table->id();
            $table->string('code')->unique();
            $table->unsignedBigInteger('question_type_id');
            $table->text('question');
            $table->json('options');
            $table->text('correct_answer');
            $table->integer('default_marks')->default(1);
            $table->integer('default_time')->default(60);
            $table->unsignedBigInteger('skill_id');
            $table->unsignedBigInteger('topic_id')->nullable();
            $table->unsignedBigInteger('difficulty_level_id')->default(1);
            $table->json('preferences')->nullable();
            $table->boolean('has_attachment')->default(0);
            $table->string('attachment_type', 45)->nullable(); // comprehension, audio, video, document
            $table->unsignedBigInteger('comprehension_passage_id')->nullable();
            $table->json('attachment_options')->nullable();
            $table->text('solution')->nullable();
            $table->json('solution_video')->nullable();
            $table->text('hint')->nullable();
            $table->integer('avg_time_taken')->default(0);
            $table->unsignedBigInteger('total_attempts')->default(0);
            $table->boolean('is_active')->default(1);
            $table->timestamps();
            $table->softDeletes();

            $table->foreign('skill_id')
                ->references('id')->on('skills')
                ->onDelete('restrict');

            $table->foreign('topic_id')
                ->references('id')->on('topics')
                ->onDelete('restrict');

            $table->foreign('comprehension_passage_id')
                ->references('id')->on('comprehension_passages')
                ->onDelete('restrict');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('questions');
    }
}
