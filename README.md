# KRA Nil Returns Filing Application

This Laravel application allows users to file nil returns through the Kenya eCitizen API.

## Features

- Simple form for filing nil returns
- Integration with the Kenya eCitizen API
- Responsive UI built with Bootstrap
- Form validation
- Error handling

## Prerequisites

- PHP 8.1+
- Composer
- Heroku CLI (for deployment)

## Local Setup

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/kra-services.git
   cd kra-services/laravel-nil-returns
   ```

2. Install dependencies:
   ```
   composer install
   ```

3. Copy `.env.example` to `.env` and set up your environment variables:
   ```
   cp .env.example .env
   php artisan key:generate
   ```

4. Set your KRA API credentials in the `.env` file:
   ```
   KRA_API_KEY=your_api_key_here
   KRA_NIL_RETURNS_ENDPOINT=https://developer.go.ke/apis/kra/nil-returns
   ```

5. Run the application:
   ```
   php artisan serve
   ```

## Deploying to Heroku

1. Log in to Heroku:
   ```
   heroku login
   ```

2. Create a new Heroku app:
   ```
   heroku create your-app-name
   ```

3. Add the PHP buildpack:
   ```
   heroku buildpacks:set heroku/php
   ```

4. Set the required environment variables:
   ```
   heroku config:set APP_KEY=$(php artisan key:generate --show)
   heroku config:set APP_ENV=production
   heroku config:set APP_DEBUG=false
   heroku config:set KRA_API_KEY=your_api_key_here
   heroku config:set KRA_NIL_RETURNS_ENDPOINT=https://developer.go.ke/apis/kra/nil-returns
   ```

5. Push to Heroku:
   ```
   git add .
   git commit -m "Ready for deployment"
   git push heroku main
   ```

6. Run database migrations:
   ```
   heroku run php artisan migrate
   ```

7. Open the app:
   ```
   heroku open
   ```

## API Documentation

For more information about the Kenya eCitizen API, visit:
[https://developer.go.ke/apis](https://developer.go.ke/apis)

## License

This project is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
