# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :google_oauth2,
#            Rails.application.credentials.oauth.GOOGLE_CLIENT_ID,
#            Rails.application.credentials.oauth.GOOGLE_CLIENT_SECRET,
#            {
#              scope: 'email', # This will allow us to get the user's email address
#              prompt: 'select_account' # This will allow the user to select which account they want to login with.
#            }
# end
