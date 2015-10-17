class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.date :day
      t.belongs_to :user, index: true
      t.belongs_to :first_course, index: true
      t.belongs_to :second_course, index: true
      t.belongs_to :drink, index: true

      t.timestamps null: false
    end
  end
end
