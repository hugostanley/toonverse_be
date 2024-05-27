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
#              accept_workforce_invitation GET    /w_auth/invitation/accept(.:format)                                                               workforce/invitations#edit
#              remove_workforce_invitation GET    /w_auth/invitation/remove(.:format)                                                               workforce/invitations#destroy
#                 new_workforce_invitation GET    /w_auth/invitation/new(.:format)                                                                  workforce/invitations#new
#                     workforce_invitation PATCH  /w_auth/invitation(.:format)                                                                      workforce/invitations#update
#                                          PUT    /w_auth/invitation(.:format)                                                                      workforce/invitations#update
#                                          POST   /w_auth/invitation(.:format)                                                                      workforce/invitations#create
#                     api_v1_user_profiles GET    /api/v1/user_profiles(.:format)                                                                   api/v1/user_profiles#index
#                                          POST   /api/v1/user_profiles(.:format)                                                                   api/v1/user_profiles#create
#                      api_v1_user_profile GET    /api/v1/user_profiles/:id(.:format)                                                               api/v1/user_profiles#show
#                                          PATCH  /api/v1/user_profiles/:id(.:format)                                                               api/v1/user_profiles#update
#                                          PUT    /api/v1/user_profiles/:id(.:format)                                                               api/v1/user_profiles#update
#                                          DELETE /api/v1/user_profiles/:id(.:format)                                                               api/v1/user_profiles#destroy
#                   api_v1_artist_profiles GET    /api/v1/artist_profiles(.:format)                                                                 api/v1/artist_profiles#index
#                                          POST   /api/v1/artist_profiles(.:format)                                                                 api/v1/artist_profiles#create
#                    api_v1_artist_profile GET    /api/v1/artist_profiles/:id(.:format)                                                             api/v1/artist_profiles#show
#                                          PATCH  /api/v1/artist_profiles/:id(.:format)                                                             api/v1/artist_profiles#update
#                                          PUT    /api/v1/artist_profiles/:id(.:format)                                                             api/v1/artist_profiles#update
#                                          DELETE /api/v1/artist_profiles/:id(.:format)                                                             api/v1/artist_profiles#destroy
#                             api_v1_items GET    /api/v1/items(.:format)                                                                           api/v1/items#index
#                                          POST   /api/v1/items(.:format)                                                                           api/v1/items#create
#                              api_v1_item GET    /api/v1/items/:id(.:format)                                                                       api/v1/items#show
#                                          PATCH  /api/v1/items/:id(.:format)                                                                       api/v1/items#update
#                                          PUT    /api/v1/items/:id(.:format)                                                                       api/v1/items#update
#                                          DELETE /api/v1/items/:id(.:format)                                                                       api/v1/items#destroy
#                          api_v1_payments GET    /api/v1/payments(.:format)                                                                        api/v1/payments#index
#                                          POST   /api/v1/payments(.:format)                                                                        api/v1/payments#create
#                           api_v1_payment GET    /api/v1/payments/:id(.:format)                                                                    api/v1/payments#show
#                                          PATCH  /api/v1/payments/:id(.:format)                                                                    api/v1/payments#update
#                                          PUT    /api/v1/payments/:id(.:format)                                                                    api/v1/payments#update
#                                          DELETE /api/v1/payments/:id(.:format)                                                                    api/v1/payments#destroy
#                            api_v1_orders GET    /api/v1/orders(.:format)                                                                          api/v1/orders#index
#                                          POST   /api/v1/orders(.:format)                                                                          api/v1/orders#create
#                             api_v1_order GET    /api/v1/orders/:id(.:format)                                                                      api/v1/orders#show
#                                          PATCH  /api/v1/orders/:id(.:format)                                                                      api/v1/orders#update
#                                          PUT    /api/v1/orders/:id(.:format)                                                                      api/v1/orders#update
#                                          DELETE /api/v1/orders/:id(.:format)                                                                      api/v1/orders#destroy
#                              api_v1_jobs GET    /api/v1/jobs(.:format)                                                                            api/v1/jobs#index
#                               api_v1_job GET    /api/v1/jobs/:id(.:format)                                                                        api/v1/jobs#show
#                          api_v1_artworks GET    /api/v1/artworks(.:format)                                                                        api/v1/artworks#index
#                                          POST   /api/v1/artworks(.:format)                                                                        api/v1/artworks#create
#                           api_v1_artwork GET    /api/v1/artworks/:id(.:format)                                                                    api/v1/artworks#show
#                                          PATCH  /api/v1/artworks/:id(.:format)                                                                    api/v1/artworks#update
#                                          PUT    /api/v1/artworks/:id(.:format)                                                                    api/v1/artworks#update
#                                          DELETE /api/v1/artworks/:id(.:format)                                                                    api/v1/artworks#destroy
#                 api_v1_webhooks_paymongo POST   /api/v1/webhooks/paymongo(.:format)                                                               api/v1/webhooks#create
#            rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)                                           action_mailbox/ingresses/postmark/inbound_emails#create
#               rails_relay_inbound_emails POST   /rails/action_mailbox/relay/inbound_emails(.:format)                                              action_mailbox/ingresses/relay/inbound_emails#create
#            rails_sendgrid_inbound_emails POST   /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                           action_mailbox/ingresses/sendgrid/inbound_emails#create
#      rails_mandrill_inbound_health_check GET    /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#health_check
#            rails_mandrill_inbound_emails POST   /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#create
#             rails_mailgun_inbound_emails POST   /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                                       action_mailbox/ingresses/mailgun/inbound_emails#create
#           rails_conductor_inbound_emails GET    /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#index
#                                          POST   /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#create
#        new_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/new(.:format)                                      rails/conductor/action_mailbox/inbound_emails#new
#            rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                                      rails/conductor/action_mailbox/inbound_emails#show
# new_rails_conductor_inbound_email_source GET    /rails/conductor/action_mailbox/inbound_emails/sources/new(.:format)                              rails/conductor/action_mailbox/inbound_emails/sources#new
#    rails_conductor_inbound_email_sources POST   /rails/conductor/action_mailbox/inbound_emails/sources(.:format)                                  rails/conductor/action_mailbox/inbound_emails/sources#create
#    rails_conductor_inbound_email_reroute POST   /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                               rails/conductor/action_mailbox/reroutes#create
# rails_conductor_inbound_email_incinerate POST   /rails/conductor/action_mailbox/:inbound_email_id/incinerate(.:format)                            rails/conductor/action_mailbox/incinerates#create
#                       rails_service_blob GET    /rails/active_storage/blobs/redirect/:signed_id/*filename(.:format)                               active_storage/blobs/redirect#show
#                 rails_service_blob_proxy GET    /rails/active_storage/blobs/proxy/:signed_id/*filename(.:format)                                  active_storage/blobs/proxy#show
#                                          GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                                        active_storage/blobs/redirect#show
#                rails_blob_representation GET    /rails/active_storage/representations/redirect/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations/redirect#show
#          rails_blob_representation_proxy GET    /rails/active_storage/representations/proxy/:signed_blob_id/:variation_key/*filename(.:format)    active_storage/representations/proxy#show
#                                          GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format)          active_storage/representations/redirect#show
#                       rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                                       active_storage/disk#show
#                update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                               active_storage/disk#update
#                     rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                                    active_storage/direct_uploads#create

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  mount_devise_token_auth_for 'Workforce', at: 'w_auth', skip: [:invitations]

  devise_for :workforce, path: 'w_auth', only: [:invitations],
                         controllers: { invitations: 'workforce/invitations' }

  namespace :api do
    namespace :v1 do
      resources :user_profiles, except: %i[new edit]
      resources :artist_profiles, except: %i[new edit]
      resources :items
      resources :payments
      resources :orders
      resources :jobs, only: %i[index show]
      resources :artworks

      # Webhook URL
      post 'webhooks/paymongo', to: 'webhooks#create'
    end
  end
end
