#!/bin/bash

# Build script for Heroku deployment

echo "Preparing application for deployment to Heroku..."

# Step 1: Create new application key
NEW_APP_KEY=$(php artisan key:generate --show)
echo "Generated new application key: $NEW_APP_KEY"

# Step 2: Add meta tag for CSRF protection in the head section
# (This is already in the Laravel template, just confirming)
echo "CSRF token is already included in the form (@csrf directive)"

# Step 3: Create or update Procfile
echo "web: vendor/bin/heroku-php-apache2 public/" > Procfile
echo "Updated Procfile"

# Step 4: Create a Heroku-ready .env file (for reference when setting config vars)
cat > .env.heroku << EOF
APP_NAME="KRA Nil Returns"
APP_ENV=production
APP_KEY=$NEW_APP_KEY
APP_DEBUG=true
APP_URL=https://your-app-name.herokuapp.com

LOG_CHANNEL=stack
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=debug

DB_CONNECTION=pgsql
DB_HOST=\${DATABASE_URL}

SESSION_DRIVER=cookie
SESSION_LIFETIME=120
SESSION_SECURE_COOKIE=true

CACHE_DRIVER=file

KRA_API_KEY=YOUR_API_KEY_HERE
KRA_NIL_RETURNS_ENDPOINT=https://developer.go.ke/apis/kra/nil-returns
EOF
echo "Created .env.heroku reference file"

# Step 5: Set up Heroku deployment (Manual step - instructions below)
echo "==== MANUAL DEPLOYMENT INSTRUCTIONS ===="
echo "1. Log in to Heroku Dashboard: https://dashboard.heroku.com/"
echo "2. Create a new app if you haven't already"
echo "3. Connect to GitHub repository or use Heroku Git"
echo "4. Set the following config variables in the Settings tab:"
echo "   - APP_KEY=$NEW_APP_KEY"
echo "   - APP_ENV=production"
echo "   - APP_DEBUG=true (for debugging, set to false in production)"
echo "   - APP_URL=https://your-app-name.herokuapp.com (replace with your actual app URL)"
echo "   - KRA_API_KEY=your_actual_api_key"
echo "   - KRA_NIL_RETURNS_ENDPOINT=https://developer.go.ke/apis/kra/nil-returns"
echo "   - SESSION_SECURE_COOKIE=true"
echo "   - SESSION_DRIVER=cookie"
echo "5. Add PostgreSQL database add-on if needed"
echo "6. Deploy your application from the Deploy tab"
echo ""
echo "NOTE: The .env.heroku file is only for reference. Heroku uses config variables set in dashboard."
echo "      You can use this command to set all variables at once if you have Heroku CLI access:"
echo ""
echo "      heroku config:set APP_NAME=\"KRA Nil Returns\" APP_ENV=production APP_KEY=$NEW_APP_KEY \\"
echo "          APP_DEBUG=true APP_URL=https://your-app-name.herokuapp.com SESSION_DRIVER=cookie \\"
echo "          SESSION_SECURE_COOKIE=true KRA_API_KEY=your_actual_api_key \\"
echo "          KRA_NIL_RETURNS_ENDPOINT=https://developer.go.ke/apis/kra/nil-returns"
echo "=========================================="

echo "Deployment preparation completed!"
