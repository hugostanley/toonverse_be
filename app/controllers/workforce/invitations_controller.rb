class Workforce::InvitationsController < Devise::InvitationsController
  include InvitableMethods
  respond_to :json
  before_action :authenticate_workforce!, only: [:create]

  def create
    Workforce.invite!(invite_params, current_user)
    render json: { success: ['Workforce created.'] }, status: :created
  end

  def edit
    redirect_to "#{client_api_url}?invitation_token=#{params[:invitation_token]}"
  end

  # PUT /resource/invitation
  def update
    raw_invitation_token = update_resource_params[:invitation_token]
    self.resource = accept_resource
    invitation_accepted = resource.errors.empty?

    if invitation_accepted
      if resource.class.allow_insecure_sign_in_after_accept
        resource.after_database_authentication
        sign_in(resource_name, resource)
        render json: { message: 'Invitation accepted successfully', data: resource }, status: :ok
      else
        render json: { message: 'Invitation accepted successfully, but the account is not active.', data: resource }, status: :ok
      end
    else
      resource.invitation_token = raw_invitation_token
      render json: { error: 'Error accepting invitation', errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  protected

  def accept_invitation_params
    params.permit(:password, :password_confirmation, :invitation_token)
  end

  def after_sign_in_path_for(resource)
    '/w/login'
  end
end
