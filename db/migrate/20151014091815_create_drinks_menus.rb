class CreateDrinksMenus < ActiveRecord::Migration
  def change
    create_table :drinks_menus do |t|
      t.belongs_to :menu, index: true
      t.belongs_to :drink, index: true
    end
  end
end
