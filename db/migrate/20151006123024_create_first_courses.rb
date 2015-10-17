class CreateFirstCourses < ActiveRecord::Migration
  def change
    create_table :first_courses do |t|
      t.string :name
      t.float :price

      t.timestamps null: false
    end
  end
end
