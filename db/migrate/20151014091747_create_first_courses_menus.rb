class CreateFirstCoursesMenus < ActiveRecord::Migration
  def change
    create_table :first_courses_menus do |t|
      t.belongs_to :menu, index: true
      t.belongs_to :first_course, index: true
    end
  end
end
