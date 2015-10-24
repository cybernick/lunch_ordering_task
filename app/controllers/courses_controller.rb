class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin

  def create
    @menu = Menu.find_by_day(Time.zone.today)
    @menu.courses.where(type: type).create(course_params)
    redirect_to items_show_path
  end

  private

  def type
    params[:type]
  end

  def admin
    redirect_to(root_url) unless current_user.admin?
  end

  def course_params
    params.require(:course).permit(:name,:price,:type)
  end
end