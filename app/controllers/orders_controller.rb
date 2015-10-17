class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin, except: :create
  def show
    @day = Menu.find_by_id(params[:id]).day
    @orders = Order.current(@day)
  end
  def create
    @menu = Menu.find_by_day(Time.zone.today)
    @order = current_user.orders.find_by_day(Time.zone.today)
    if @order.nil?
      @order = current_user.orders.create(order_params)
    else
      @order.update(order_params)
    end
    redirect_to menu_path(@menu)
  end
  private
  def admin
    redirect_to(root_url) unless current_user.admin?
  end
  def order_params
    params.permit(:day,:first_course_id,:second_course_id,:drink_id)
  end
end