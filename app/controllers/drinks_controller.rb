class DrinksController < ApplicationController
  before_action :authenticate_user!
  before_action :admin

  def create
    @menu = Menu.find_by_day(Time.zone.today)
    @drink = @menu.drinks.create(drink_params)
    redirect_to items_show_path
  end
  private
  def admin
    redirect_to(root_url) unless current_user.admin?
  end
  def drink_params
    params.require(:drink).permit(:name,:price)
  end
end