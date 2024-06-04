# ToonVerse API
A Rails API for [ToonVerse - ReactTs](https://github.com/hugostanley/toonverse_fe.git). 
This is a collaboration project made by Jean Bejar, Cyril Cero, Louise Dungca, and Jewel Milagrosa of Avion School Batch 32.

## Dependencies / Gems
- **PostgreSQL:** Database management system for storing user information and transaction history.
- **Devise:** Flexible authentication solution for Rails.
  - **Devise Invitable:** Adds support for sending invitations by email.
- **Devise-Token-Auth:** Token based authentication for Rails JSON APIs. 
- **Annotate:** Automatically adds schema information to models.
- **Letter Opener:** Preview email in the browser instead of sending it.

Check the Gemfile and Gemfile.lock for the full list of gems and their versions.

## Setup
1. Fork and clone this repository.
```bash
$ git clone git@github.com:hugostanley/toonverse_be.git
$ bundle install

```

2. Generate a new master.key and configure your credentials:
```bash
$ rails credentials:edit
```
```yaml
# tmp/some_timestamp_and_id-credentials.yml

outlook_smtp:
  email: email@outlook.com
  password: password

development:
  frontend_base_url: http://localhost:5173

production:
  frontend_base_url: https://your-production-url.com

# aws:
#   access_key_id: some_generated_id
#   secret_access_key: some_generated_key

# Used as the base secret for all MessageVerifiers in Rails, including the one protecting cookies.
secret_key_base: generated_secret_key
```

3. Start the application:
```bash
$ bin/rails db:prepare
$ bin/dev
```
The application should now be accessible at http://localhost:3000 in your web browser.

## Endpoints

### Authentication

- **Sign In**
  - `POST /auth/sign_in`
- **Sign Out**
  - `DELETE /auth/sign_out`
- **Password**
  - `POST /auth/password`
  - `PUT /auth/password`
- **Registration**
  - `POST /auth`
  - `PUT /auth`
  - `DELETE /auth`
- **Token Validation**
  - `GET /auth/validate_token`

### Workforce Authentication

- **Sign In**
  - `POST /w_auth/sign_in`
- **Sign Out**
  - `DELETE /w_auth/sign_out`
- **Password**
  - `POST /w_auth/password`
  - `PUT /w_auth/password`
- **Registration**
  - `POST /w_auth`
  - `PUT /w_auth`
  - `DELETE /w_auth`
- **Token Validation**
  - `GET /w_auth/validate_token`

### Workforce Invitations

- **Accept Invitation**
  - `GET /w_auth/invitation/accept`
- **Remove Invitation**
  - `GET /w_auth/invitation/remove`
- **New Invitation**
  - `GET /w_auth/invitation/new`
- **Update Invitation**
  - `POST /w_auth/invitation`
  - `PUT /w_auth/invitation`

### API Endpoints

- **User Profiles**
  - `GET    /api/v1/user_profiles`
  - `POST   /api/v1/user_profiles`
  - `GET    /api/v1/user_profiles/:id`
  - `PATCH  /api/v1/user_profiles/:id`
  - `PUT    /api/v1/user_profiles/:id`
  - `DELETE /api/v1/user_profiles/:id`
  
- **Artist Profiles**
  - `GET    /api/v1/artist_profiles`
  - `POST   /api/v1/artist_profiles`
  - `GET    /api/v1/artist_profiles/:id`
  - `PATCH  /api/v1/artist_profiles/:id`
  - `PUT    /api/v1/artist_profiles/:id`
  - `DELETE /api/v1/artist_profiles/:id`
  
- **Items**
  - `GET    /api/v1/items`
  - `POST   /api/v1/items`
  - `GET    /api/v1/items/:id`
  - `PATCH  /api/v1/items/:id`
  - `PUT    /api/v1/items/:id`
  - `DELETE /api/v1/items/:id`
  
- **Payments**
  - `GET    /api/v1/payments`
  - `POST   /api/v1/payments`
  - `GET    /api/v1/payments/:id`
  - `PATCH  /api/v1/payments/:id`
  - `PUT    /api/v1/payments/:id`
  - `DELETE /api/v1/payments/:id`
  
- **Orders**
  - `GET    /api/v1/orders`
  - `POST   /api/v1/orders`
  - `GET    /api/v1/orders/:id`
  - `PATCH  /api/v1/orders/:id`
  - `PUT    /api/v1/orders/:id`
  - `DELETE /api/v1/orders/:id`
  
- **Jobs**
  - `GET    /api/v1/jobs`
  - `GET    /api/v1/jobs/:id`
  
- **Artworks**
  - `GET    /api/v1/artworks`
  - `POST   /api/v1/artworks`
  - `GET    /api/v1/artworks/:id`
  - `PATCH  /api/v1/artworks/:id`
  - `PUT    /api/v1/artworks/:id`
  - `DELETE /api/v1/artworks/:id`
  
- **Webhooks (Paymongo)**
  - `POST   /api/v1/webhooks/paymongo`