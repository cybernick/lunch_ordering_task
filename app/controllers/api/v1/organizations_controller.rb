class Api::V1::OrganizationsController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!
  def show
    respond_with User.find(params[:id])
  end
end