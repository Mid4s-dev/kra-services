#!/bin/bash

# Script to set Heroku config variables at once
# Must have Heroku CLI installed and authenticated

# Check if Heroku CLI is installed
if ! command -v heroku &> /dev/null; then
    echo "Heroku CLI is not installed. Please install it first."
    echo "Visit: https://devcenter.heroku.com/articles/heroku-cli"
    exit 1
fi

# Get app name from user
read -p "Enter your Heroku app name: " APP_NAME

if [ -z "$APP_NAME" ]; then
    echo "App name cannot be empty."
    exit 1
fi

# Check if the app exists
heroku apps:info --app "$APP_NAME" &> /dev/null
if [ $? -ne 0 ]; then
    echo "App '$APP_NAME' does not exist or you don't have access to it."
    exit 1
fi

# Get the API key
read -p "Enter your KRA API key: " KRA_API_KEY

if [ -z "$KRA_API_KEY" ]; then
    echo "API key not provided. Using placeholder value."
    KRA_API_KEY="YOUR_API_KEY_HERE"
fi

# Get APP_KEY from .env.heroku
APP_KEY=$(grep APP_KEY .env.heroku | cut -d= -f2)

# Set all config variables at once
echo "Setting config variables for $APP_NAME..."
heroku config:set \
    APP_NAME="KRA Nil Returns" \
    APP_ENV=production \
    APP_KEY=$APP_KEY \
    APP_DEBUG=true \
    APP_URL="https://$APP_NAME.herokuapp.com" \
    SESSION_DRIVER=cookie \
    SESSION_SECURE_COOKIE=true \
    KRA_API_KEY="$KRA_API_KEY" \
    KRA_NIL_RETURNS_ENDPOINT="https://developer.go.ke/apis/kra/nil-returns" \
    --app $APP_NAME

echo "Config variables set successfully!"
echo ""
echo "Next steps:"
echo "1. Deploy your application: git push heroku main"
echo "2. Open your app: heroku open --app $APP_NAME"
echo ""
echo "Remember to set APP_DEBUG=false once everything is working correctly."
