class FirstCoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user

  def create
    @menu = Menu.find_by_day(Time.zone.today)
    @first_course = @menu.first_courses.create(first_course_params)
    redirect_to items_show_path
  end
  private
  def correct_user
    redirect_to(root_url) unless current_user.admin?
  end
  def first_course_params
    params.require(:first_course).permit(:name,:price)
  end
end