class UsersController < ApplicationController
  before_action :authenticate_user!, :admin

  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def admin
    unless current_user.admin?
      if params[:id] == nil
        redirect_to(root_url)
      else
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user == @user
      end
    end
  end
end
