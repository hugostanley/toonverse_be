class Workforce::InvitationsController < Devise::InvitationsController
  def edit
    sign_out send("current_#{resource_name}") if send("#{resource_name}_signed_in?")
    set_minimum_password_length
    resource.invitation_token = params[:invitation_token]
    redirect_to "#{Rails.application.credentials.dig(Rails.env.to_sym, :frontend_base_url)}/w/invitation/accept?invitation_token=#{params[:invitation_token]}"
  end

  def update
    super do |resource|
      if resource.errors.empty?
        render json: { status: "Invitation Accepted!" }, status: :ok and return
      else
        render json: resource.errors, status: :unprocessable_entity and return
      end
    end
  end
end
