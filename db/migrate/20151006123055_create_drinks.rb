class CreateDrinks < ActiveRecord::Migration
  def change
    create_table :drinks do |t|
      t.string :name
      t.float :price

      t.timestamps null: false
    end
  end
end
