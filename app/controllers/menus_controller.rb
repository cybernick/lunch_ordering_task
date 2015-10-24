class MenusController < ApplicationController
  before_action :authenticate_user!

  def show
    @menu = Menu.find_by_id(params[:id])
    @first_courses = @menu.first_courses
    @second_courses = @menu.second_courses
    @drink_courses = @menu.drinks
    @order = current_user.orders.new
    @first_course_options = @first_courses.all.map{|c| [ c.name_with_price, c.id ] }
    @second_course_options = @second_courses.all.map{|c| [ c.name_with_price, c.id ] }
    @drink_options = @drink_courses.all.map{|c| [ c.name_with_price, c.id ] }
    @current_order = current_user.orders.find_by_day(@menu.day)
  end
end