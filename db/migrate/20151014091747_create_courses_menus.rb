class CreateCoursesMenus < ActiveRecord::Migration
  def change
    create_table :courses_menus do |t|
      t.belongs_to :menu, index: true
      t.belongs_to :course, index: true
    end
  end
end
