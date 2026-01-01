<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Ticket;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;


class TicketController extends Controller
{
    public function index(Request $request)
    {
        $query = Ticket::with(['organization', 'vessel', 'serviceLine','assignedUser',]);

        if ($request->search) {
            $query->where('title', 'like', '%' . $request->search . '%')
                ->orWhere('description', 'like', '%' . $request->search . '%');
        }


        $perPage = $request->per_page ?? 10;
        $tickets = $query->paginate($perPage);

        return response()->json($tickets);
    }



    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'required|string',
            'contact_email' => 'required|email',
            'cc_email' => 'nullable|email',
            'priority' => 'required|in:High,Medium,Low',

            'organization_id' => 'required|exists:organizations,id',
            'vessel_id' => 'nullable|exists:vessels,id',
            'service_line_id' => 'nullable|exists:service_lines,id',

            'category' => 'nullable|string|max:100',
            'status' => 'nullable|in:Open,In Progress,Resolved,Closed',

        ]);


        $lastTicket = Ticket::latest('id')->first();
        $nextNumber = $lastTicket ? ($lastTicket->id + 1) : 1;


        $ticketNumber = '#' . str_pad($nextNumber, 6, '0', STR_PAD_LEFT);

        $ticket = Ticket::create([
            ...$validated,
            'ticket_number' => $ticketNumber,
            'assigned_user_id' => Auth::id(),
        ]);

        
        $ticket->load(['organization', 'vessel', 'serviceLine', 'assignedUser']);

        return response()->json($ticket, 201);
    }

    public function show($id)
    {
        return Ticket::with(['organization', 'vessel', 'serviceLine', 'assignedUser'])->findOrFail($id);
    }

    public function update(Request $request, $id)
    {
        $ticket = Ticket::findOrFail($id);
        $data = $request->except(['assigned_user_id']);

        $ticket->update($data);

        return $ticket->load(['assignedUser']);
    }

    public function destroy($id)
    {
        Ticket::findOrFail($id)->delete();
        return response()->json(null, 204);
    }
}
