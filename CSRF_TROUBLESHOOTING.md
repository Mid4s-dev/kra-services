## CSRF Troubleshooting Guide

If you're experiencing CSRF token mismatches or 500 errors related to CSRF verification on Heroku, try the following steps:

### 1. Check If Your App Key Is Set Properly

Make sure your APP_KEY is set in Heroku's environment variables:

```bash
# Check if APP_KEY exists (requires Heroku CLI with proper authentication)
heroku config | grep APP_KEY
```

If not set or you need to update it, set it manually:

```bash
heroku config:set APP_KEY=base64:FlOqBV1AiQ49uBkLL5SO9U6WAot9ibI1GI4tlRglneI=
```

### 2. Check Secure Cookies Settings

If you're having issues with secure cookies (especially if your app is on HTTPS), add these settings:

```bash
heroku config:set SESSION_SECURE_COOKIE=true
```

### 3. Clear Heroku's Cache

Sometimes clearing the cache helps:

```bash
heroku run php artisan cache:clear
heroku run php artisan config:clear
heroku run php artisan view:clear
heroku run php artisan route:clear
```

### 4. Check Your .htaccess File

Make sure your .htaccess file in the public directory has the proper CSRF token handling:

```
# Handle X-XSRF-Token Header
RewriteCond %{HTTP:x-xsrf-token} .
RewriteRule .* - [E=HTTP_X_XSRF_TOKEN:%{HTTP:X-XSRF-Token}]
```

### 5. Use JavaScript to Add CSRF Token to AJAX Requests

If you're making AJAX requests, make sure to include the CSRF token:

```javascript
$.ajaxSetup({
    headers: {
        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
    }
});
```

### 6. Check for Cookie Issues

If using subdomains or custom domains, make sure your session domain is set correctly:

```bash
heroku config:set SESSION_DOMAIN=.yourdomain.com
```

### 7. Temporarily Disable CSRF for Testing

**IMPORTANT: Only for testing, not for production!**
You can temporarily exclude routes from CSRF verification by adding them to the `$except` array in the `VerifyCsrfToken` middleware.

### 8. Check Logs for More Information

```bash
heroku logs --tail
```

### 9. Make Sure the Form Has @csrf Directive

All forms should include the `@csrf` directive:

```blade
<form method="POST" action="{{ route('your.route') }}">
    @csrf
    <!-- form fields -->
</form>
```
