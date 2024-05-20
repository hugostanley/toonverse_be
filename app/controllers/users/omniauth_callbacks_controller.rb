class Users::OmniauthCallbacksController <  DeviseTokenAuth::OmniauthCallbacksController
  # skip_before_action :verify_authenticity_token, only: [:google_oauth2]
  include DeviseTokenAuth::Concerns::SetUserByToken

  def google_oauth2
    puts "Executing GOOGLE_OAUTH2 method..."

    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in @user, event: :authentication
      response.headers['X-CSRF-Token'] = form_authenticity_token
      render json: { message: "Authentication successful", user: @user }, status: :ok
    else
      render json: {
        error: "Authentication failed",
        errors: @user.errors.full_messages
      },
      status: :unprocessable_entity
    end
  end

  def failure
    render json: {
      error: "Authentication failed",
      message: params[:message].humanize
    },
    status: :unprocessable_entity
  end
end
