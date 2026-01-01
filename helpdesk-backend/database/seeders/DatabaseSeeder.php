<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Organization;
use App\Models\Vessel;
use App\Models\ServiceLine;
use App\Models\Ticket;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Seed the application's database.
     */
    public function run(): void
    {

        User::create([
            'name' => 'Admin',
            'email' => 'admin@helpdesk.com',
            'password' => bcrypt('admin1234'),
        ]);

        User::create([
            'name' => 'Test User',
            'email' => 'test@helpdesk.com',
            'password' => bcrypt('1234'),
        ]);

        // Organizations
        Organization::create(['name' => 'บริษัท เอเชีย มาริไทม์ จำกัด']);
        Organization::create(['name' => 'บริษัท ไทย แทงเกอร์ จำกัด']);

        // Vessels
        Vessel::create(['name' => 'MV Asia Star']);
        Vessel::create(['name' => 'MV Thai Pride']);

        // Service Lines
        ServiceLine::create(['name' => 'Thailand - Singapore']);
        ServiceLine::create(['name' => 'Thailand - Japan']);

        // Tickets ตัวอย่าง
        Ticket::create([
            'title' => 'เครื่องยนต์มีปัญหา',
            'description' => 'เครื่องยนต์หลักมีเสียงดังผิดปกติระหว่างเดินทาง',
            'contact_email' => 'captain@asiamaritime.com',
            'priority' => 'High',
            'organization_id' => 1,
            'vessel_id' => 1,
            'service_line_id' => 1,
            'assigned_user_id' => 1,
        ]);

        Ticket::create([
            'title' => 'ระบบไฟฟ้าขัดข้อง',
            'description' => 'ไฟในห้องเครื่องดับบ่อย',
            'contact_email' => 'engineer@thaitanker.com',
            'priority' => 'Medium',
            'organization_id' => 2,
            'vessel_id' => 2,
            'service_line_id' => 2,
        ]);
    }
}
