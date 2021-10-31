<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePracticeSetsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('practice_sets', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->string('slug')->unique();
            $table->string('code')->unique();
            $table->unsignedBigInteger('sub_category_id');
            $table->unsignedBigInteger('skill_id');
            $table->text('description')->nullable();
            $table->unsignedInteger('total_questions')->default(0);
            $table->boolean('auto_grading')->default(1);
            $table->unsignedInteger('correct_marks')->nullable();
            $table->boolean('allow_rewards')->default(1);
            $table->json('settings')->nullable();
            $table->boolean('is_active')->default(1);
            $table->timestamps();
            $table->softDeletes();

            $table->foreign('skill_id')
                ->references('id')->on('skills')
                ->onDelete('restrict');

            $table->foreign('sub_category_id')
                ->references('id')->on('sub_categories')
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
        Schema::dropIfExists('practice_sets');
    }
}
