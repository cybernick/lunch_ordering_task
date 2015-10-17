class CreateSecondCourses < ActiveRecord::Migration
  def change
    create_table :second_courses do |t|
      t.string :name
      t.float :price

      t.timestamps null: false
    end
  end
end
