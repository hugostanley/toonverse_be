# == Route Map
#
#                                   Prefix Verb   URI Pattern                                                                                       Controller#Action
#                         new_user_session GET    /auth/sign_in(.:format)                                                                           devise_token_auth/sessions#new
#                             user_session POST   /auth/sign_in(.:format)                                                                           devise_token_auth/sessions#create
#                     destroy_user_session DELETE /auth/sign_out(.:format)                                                                          devise_token_auth/sessions#destroy
#                        new_user_password GET    /auth/password/new(.:format)                                                                      devise_token_auth/passwords#new
#                       edit_user_password GET    /auth/password/edit(.:format)                                                                     devise_token_auth/passwords#edit
#                            user_password PATCH  /auth/password(.:format)                                                                          devise_token_auth/passwords#update
#                                          PUT    /auth/password(.:format)                                                                          devise_token_auth/passwords#update
#                                          POST   /auth/password(.:format)                                                                          devise_token_auth/passwords#create
#                 cancel_user_registration GET    /auth/cancel(.:format)                                                                            devise_token_auth/registrations#cancel
#                    new_user_registration GET    /auth/sign_up(.:format)                                                                           devise_token_auth/registrations#new
#                   edit_user_registration GET    /auth/edit(.:format)                                                                              devise_token_auth/registrations#edit
#                        user_registration PATCH  /auth(.:format)                                                                                   devise_token_auth/registrations#update
#                                          PUT    /auth(.:format)                                                                                   devise_token_auth/registrations#update
#                                          DELETE /auth(.:format)                                                                                   devise_token_auth/registrations#destroy
#                                          POST   /auth(.:format)                                                                                   devise_token_auth/registrations#create
#                      auth_validate_token GET    /auth/validate_token(.:format)                                                                    devise_token_auth/token_validations#validate_token
#
#                    new_workforce_session GET    /w_auth/sign_in(.:format)                                                                         devise_token_auth/sessions#new
#                        workforce_session POST   /w_auth/sign_in(.:format)                                                                         devise_token_auth/sessions#create
#                destroy_workforce_session DELETE /w_auth/sign_out(.:format)                                                                        devise_token_auth/sessions#destroy
#                   new_workforce_password GET    /w_auth/password/new(.:format)                                                                    devise_token_auth/passwords#new
#                  edit_workforce_password GET    /w_auth/password/edit(.:format)                                                                   devise_token_auth/passwords#edit
#                       workforce_password PATCH  /w_auth/password(.:format)                                                                        devise_token_auth/passwords#update
#                                          PUT    /w_auth/password(.:format)                                                                        devise_token_auth/passwords#update
#                                          POST   /w_auth/password(.:format)                                                                        devise_token_auth/passwords#create
#            cancel_workforce_registration GET    /w_auth/cancel(.:format)                                                                          devise_token_auth/registrations#cancel
#               new_workforce_registration GET    /w_auth/sign_up(.:format)                                                                         devise_token_auth/registrations#new
#              edit_workforce_registration GET    /w_auth/edit(.:format)                                                                            devise_token_auth/registrations#edit
#                   workforce_registration PATCH  /w_auth(.:format)                                                                                 devise_token_auth/registrations#update
#                                          PUT    /w_auth(.:format)                                                                                 devise_token_auth/registrations#update
#                                          DELETE /w_auth(.:format)                                                                                 devise_token_auth/registrations#destroy
#                                          POST   /w_auth(.:format)                                                                                 devise_token_auth/registrations#create
#                    w_auth_validate_token GET    /w_auth/validate_token(.:format)                                                                  devise_token_auth/token_validations#validate_token
#
#                     api_v1_user_profiles GET    /api/v1/user_profiles(.:format)                                                                   api/v1/user_profiles#index
#                                          POST   /api/v1/user_profiles(.:format)                                                                   api/v1/user_profiles#create
#                      api_v1_user_profile GET    /api/v1/user_profiles/:id(.:format)                                                               api/v1/user_profiles#show
#                                          PATCH  /api/v1/user_profiles/:id(.:format)                                                               api/v1/user_profiles#update
#                                          PUT    /api/v1/user_profiles/:id(.:format)                                                               api/v1/user_profiles#update
#                                          DELETE /api/v1/user_profiles/:id(.:format)                                                               api/v1/user_profiles#destroy
#
#                   api_v1_artist_profiles GET    /api/v1/artist_profiles(.:format)                                                                 api/v1/artist_profiles#index
#                                          POST   /api/v1/artist_profiles(.:format)                                                                 api/v1/artist_profiles#create
#                    api_v1_artist_profile GET    /api/v1/artist_profiles/:id(.:format)                                                             api/v1/artist_profiles#show
#                                          PATCH  /api/v1/artist_profiles/:id(.:format)                                                             api/v1/artist_profiles#update
#                                          PUT    /api/v1/artist_profiles/:id(.:format)                                                             api/v1/artist_profiles#update
#                                          DELETE /api/v1/artist_profiles/:id(.:format)                                                             api/v1/artist_profiles#destroy
#

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  mount_devise_token_auth_for 'Workforce', at: 'w_auth'

  # devise_for :users, at: 'auth', controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  match '/auth/:provider/callback', to: 'users/omniauth_callbacks#google_oauth2', via: %i[get post]

  namespace :api do
    namespace :v1 do
      resources :user_profiles, except: %i[new edit]
      resources :artist_profiles, except: %i[new edit]
    end
  end
end
