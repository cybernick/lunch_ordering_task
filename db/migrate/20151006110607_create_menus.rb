class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.date :day
      t.timestamps null: false
    end
  end
end
