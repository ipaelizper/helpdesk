<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Ticket extends Model
{
    use HasFactory;

    protected $fillable = [
        'title',
        'description',
        'contact_email',
        'cc_email',
        'priority',
        'organization_id',
        'vessel_id',
        'service_line_id',
        'assigned_user_id',
        'ticket_number',
        'category',
        'status',
    ];

    // ความสัมพันธ์ (belongsTo)
    public function organization()
    {
        return $this->belongsTo(Organization::class);
    }

    public function vessel()
    {
        return $this->belongsTo(Vessel::class);
    }

    public function serviceLine()
    {
        return $this->belongsTo(ServiceLine::class);
    }

    public function assignedUser()
    {
        return $this->belongsTo(User::class, 'assigned_user_id');
    }
}
