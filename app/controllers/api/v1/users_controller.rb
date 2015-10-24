class Api::V1::UsersController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!
  def show
    respond_with User.where(organization: current_organization).find(params[:id])
  end
  def index
    respond_with User.where(organization: current_organization)
  end
end
