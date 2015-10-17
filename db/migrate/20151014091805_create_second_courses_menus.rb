class CreateSecondCoursesMenus < ActiveRecord::Migration
  def change
    create_table :second_courses_menus do |t|
      t.belongs_to :menu, index: true
      t.belongs_to :second_course, index: true
    end
  end
end
