module InvitableMethods
  extend ActiveSupport::Concern

  def authenticate_inviter!
    # use authenticate_user! in before_action
  end

  def authenticate_workforce!
    return if current_workforce
    render json: {
      errors: ['Authorized users only.']
    }, status: :unauthorized
  end

  def resource_class(m = nil)
    if m
      mapping = Devise.mappings[m]
    else
      mapping = Devise.mappings[resource_name] || Devise.mappings.values.first
    end
    mapping.to
  end

  def validate_uniqueness
    email = invite_params[:email]
    return unless Workforce.exists?(email:)

    self.resource = resource_class.new(invite_params)
    render json: { error: 'Email is already taken', errors: resource.errors.full_messages }, status: :unprocessable_entity
  end
end
