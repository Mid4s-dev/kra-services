<?php

use App\Http\Controllers\NilReturnController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return redirect()->route('nil-returns.index');
});

Route::get('/nil-returns', [NilReturnController::class, 'index'])->name('nil-returns.index');
Route::post('/nil-returns/file', [NilReturnController::class, 'fileNilReturn'])->name('nil-returns.file');
