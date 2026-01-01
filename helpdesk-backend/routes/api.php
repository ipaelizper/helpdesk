<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\TicketController;
use App\Http\Controllers\AuthController;


Route::post('/login', [AuthController::class, 'login']);

Route::get('/organizations', fn () => \App\Models\Organization::all());
Route::get('/vessels', fn () => \App\Models\Vessel::all());
Route::get('/service-lines', fn () => \App\Models\ServiceLine::all());

Route::middleware('auth:sanctum')->group(function () {

    Route::post('/logout', [AuthController::class, 'logout']);

    Route::get('/user', function (Request $request) {
        return $request->user();
    });

    Route::apiResource('tickets', TicketController::class);
});
