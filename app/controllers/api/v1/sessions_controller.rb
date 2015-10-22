class Api::V1::SessionsController < ApplicationController
  def create
    org_password = params[:session][:password]
    org_email = params[:session][:email]
    org = org_email.present? && Organization.find_by(email: org_email)

    if org.valid_password? org_password
      sign_in org, store: false
      org.generate_authentication_token!
      org.save
      render json: org, status: 200, location: [:api, org]
    else
      render json: { errors: 'Invalid email or password' }, status: 422
    end
  end
  def destroy
    organization = Organization.find_by(auth_token: params[:id])
    organization.generate_authentication_token!
    organization.save
    head 204
  end
end
