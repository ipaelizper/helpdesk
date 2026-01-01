<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('tickets', function (Blueprint $table) {
        $table->id();
        $table->string('title');
        $table->text('description');
        $table->string('contact_email');
        $table->enum('priority', ['High', 'Medium', 'Low']);
        $table->foreignId('organization_id')->constrained()->onDelete('cascade');
        $table->foreignId('vessel_id')->constrained()->onDelete('cascade');
        $table->foreignId('service_line_id')->constrained()->onDelete('cascade');
        $table->foreignId('assigned_user_id')->nullable()->constrained('users')->onDelete('set null');
        $table->timestamps();
    });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tickets');
    }
};
