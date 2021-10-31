<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUserGroupQuizSchedulesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('user_group_quiz_schedules', function (Blueprint $table) {
            $table->unsignedBigInteger('quiz_schedule_id');
            $table->unsignedBigInteger('user_group_id');

            $table->foreign('quiz_schedule_id')
                ->references('id')
                ->on('quiz_schedules')
                ->onDelete('cascade');

            $table->foreign('user_group_id')
                ->references('id')
                ->on('user_groups')
                ->onDelete('cascade');

            $table->primary(['quiz_schedule_id', 'user_group_id']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('user_group_quiz_schedules');
    }
}
