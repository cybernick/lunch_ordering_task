class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin

  def show
    @menu = Menu.find_by_day(Time.zone.today)
    @menu = Menu.create!(day: Time.zone.today) if @menu.nil?
    @first_courses = @menu.first_courses
    @second_courses = @menu.second_courses
    @drink_courses = @menu.drinks
    @course = Course.new
  end

  private

  def admin
    redirect_to(root_path) unless current_user.admin?
  end
end