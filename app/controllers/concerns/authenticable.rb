module Authenticable

  # Devise methods overwrites
  def authenticate_with_token!
    render json: { errors: 'Not authenticated' },
           status: :unauthorized unless current_organization.present?
  end
  def current_organization
    @current_organization ||= Organization.find_by(auth_token: request.headers['Authorization'])
  end
end