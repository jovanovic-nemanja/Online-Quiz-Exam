<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDiscTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('disc', function (Blueprint $table) {
            $table->id();

            $table->unsignedBigInteger('user_id');
            $table->integer('question_id');
            $table->text('session_code');
            $table->integer('current_question');
            $table->string('answer');
            
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('disc');
    }
}
