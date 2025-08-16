<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KRA Nil Returns Filing</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">File KRA Nil Return</h4>
                    </div>
                    <div class="card-body">
                        @if(session('success'))
                            <div class="alert alert-success">
                                {{ session('success') }}
                            </div>
                        @endif

                        @if($errors->any())
                            <div class="alert alert-danger">
                                <ul class="mb-0">
                                    @foreach($errors->all() as $error)
                                        <li>{{ $error }}</li>
                                    @endforeach
                                </ul>
                            </div>
                        @endif

                        <form method="POST" action="{{ route('nil-returns.file') }}">
                            @csrf
                            <div class="mb-3">
                                <label for="kra_pin" class="form-label">KRA PIN</label>
                                <input type="text" class="form-control" id="kra_pin" name="kra_pin" 
                                    value="{{ old('kra_pin') }}" required 
                                    placeholder="A123456789B" maxlength="11">
                                <small class="text-muted">Enter your 11-character KRA PIN</small>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="tax_period_month" class="form-label">Month</label>
                                    <select class="form-select" id="tax_period_month" name="tax_period_month" required>
                                        <option value="">Select Month</option>
                                        @for($i = 1; $i <= 12; $i++)
                                            <option value="{{ $i }}" {{ old('tax_period_month') == $i ? 'selected' : '' }}>
                                                {{ date('F', mktime(0, 0, 0, $i, 1)) }}
                                            </option>
                                        @endfor
                                    </select>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="tax_period_year" class="form-label">Year</label>
                                    <select class="form-select" id="tax_period_year" name="tax_period_year" required>
                                        <option value="">Select Year</option>
                                        @for($i = date('Y'); $i >= 2020; $i--)
                                            <option value="{{ $i }}" {{ old('tax_period_year') == $i ? 'selected' : '' }}>
                                                {{ $i }}
                                            </option>
                                        @endfor
                                    </select>
                                </div>
                            </div>

                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary">File Nil Return</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
