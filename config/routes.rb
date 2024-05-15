# == Route Map
#

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api do
    namespace :v1 do
      resources :user_profiles, except: [:new, :edit]
    end
  end

end
