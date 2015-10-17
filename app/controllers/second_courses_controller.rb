class SecondCoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user

  def create
    @menu = Menu.find_by_day(Time.zone.today)
    @second_course = @menu.second_courses.create(second_course_params)
    redirect_to items_show_path
  end
  private
  def correct_user
    redirect_to(root_url) unless current_user.admin?
  end
  def second_course_params
    params.require(:second_course).permit(:name,:price)
  end
end