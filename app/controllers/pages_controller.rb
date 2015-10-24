class PagesController < ApplicationController
  before_action :authenticate_user!,:except => [:home, :help,  :contact ,:about]
  before_action :admin,:except => [:home, :help, :menu, :contact ,:about]

  def home
  end

  def help
  end

  def menu
    @menus = Menu.all
  end

  def order
    @menus = Menu.all
  end

  def today
    @orders = Order.today_orders
    @total_cost = Order.total_cost
  end

  def contact
  end

  def about
  end
  
  private

  def admin
    redirect_to(root_url) unless current_user.admin?
  end
end
