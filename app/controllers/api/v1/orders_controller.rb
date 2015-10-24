class Api::V1::OrdersController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!
  def index
    @users = User.where(organization: current_organization)
    respond_with Order.where(day: Time.zone.today).where(user: @users)
  end
end