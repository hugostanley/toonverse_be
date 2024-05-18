class Users::OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
  skip_forgery_protection
  skip_before_action :verify_authenticity_token
  respond_to :json

  def google_oauth2
    generic_callback
  end

  private

  def generic_callback
    auth = request.env['omniauth.auth']

    user = User.from_omniauth(auth)

    if user.persisted?
      return serialize_response(
        resource: user,
        options: response_options(user_id: user.id),
        status: :created
      )
    end

    # Raise custom 'Unauthenticated' error message.
    raise Errors::Unauthenticated.new(message: 'Invalid social credentials')
  end
end
