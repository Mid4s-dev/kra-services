<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class NilReturnController extends Controller
{
    /**
     * Show the form for filing a nil return.
     */
    public function index()
    {
        return view('nil-returns.index');
    }

    /**
     * Process the nil return submission.
     */
    public function fileNilReturn(Request $request)
    {
        $request->validate([
            'kra_pin' => 'required|string|min:11|max:11',
            'tax_period_month' => 'required|integer|min:1|max:12',
            'tax_period_year' => 'required|integer|min:2000|max:2099',
        ]);

        try {
            // Make API call to Kenya eCitizen API
            $response = Http::withToken(config('services.kra.api_key'))
                ->post(config('services.kra.nil_returns_endpoint'), [
                    'kra_pin' => $request->kra_pin,
                    'tax_period_month' => $request->tax_period_month,
                    'tax_period_year' => $request->tax_period_year,
                ]);

            if ($response->successful()) {
                return back()->with('success', 'Nil return successfully filed!');
            }

            return back()->withErrors(['api_error' => 'Failed to file nil return: ' . $response->json('message', 'Unknown error')]);
        } catch (\Exception $e) {
            return back()->withErrors(['api_error' => 'Failed to file nil return: ' . $e->getMessage()]);
        }
    }
}
