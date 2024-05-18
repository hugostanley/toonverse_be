class Users::OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
  def authenticate_social_auth_user
    #  params is the response I receive from the client with the data from the provider about the user
    @user = User.signin_or_create_from_provider(params) # this method add a user who is new or logins an old one
    if @user.persisted?
      # I log the user in at this point
      sign_in(@user)
      # after user is loggedIn, I generate a new_token here
      login_token = @user.create_new_auth_token
      render json: {
        status: 'SUCCESS',
        message: "user was successfully logged in through #{params[:provider]}",
        headers: login_token
      },
      status: :created
    else
      render json: {
        status: 'FAILURE',
        message: "There was a problem signing you in through #{params[:provider]}",
        data: @user.errors
      },
      status: :unprocessable_entity
    end
  end
end
