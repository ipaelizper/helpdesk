<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Organization extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
    ];

    // ความสัมพันธ์แบบ one-to-many กับ Ticket
    public function tickets()
    {
        return $this->hasMany(Ticket::class);
    }
}
