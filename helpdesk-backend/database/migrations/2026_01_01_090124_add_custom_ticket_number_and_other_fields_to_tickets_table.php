<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('tickets', function (Blueprint $table) {
            $table->string('ticket_number', 7)->unique()->nullable()->after('id');
            $table->string('cc_email')->nullable()->after('contact_email');
            $table->string('category')->nullable()->after('priority');
            $table->string('status')->default('Open')->after('category');
        });
    }

    public function down(): void
    {
        Schema::table('tickets', function (Blueprint $table) {
            $table->dropColumn([
                'ticket_number',
                'cc_email',
                'category',
                'status'
            ]);
        });
    }
};
