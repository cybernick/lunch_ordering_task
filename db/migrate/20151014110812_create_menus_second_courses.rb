class CreateMenusSecondCourses < ActiveRecord::Migration
  def change
    create_table :menus_second_courses do |t|
      t.belongs_to :menu, index: true
      t.belongs_to :second_course, index: true
    end
  end
end
