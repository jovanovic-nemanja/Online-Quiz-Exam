<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePracticeSessionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('practice_sessions', function (Blueprint $table) {
            $table->id();
            $table->uuid('code')->unique();
            $table->unsignedBigInteger('practice_set_id');
            $table->unsignedBigInteger('user_id');
            $table->integer('total_time_taken')->default(0);
            $table->decimal('percentage_completed', 5, 2)->default(0.00);
            $table->unsignedInteger('total_points_earned')->default(0);
            $table->string('status')->default('started')->index();
            $table->dateTime('completed_at')->nullable();
            $table->json('results')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('practice_sessions');
    }
}
