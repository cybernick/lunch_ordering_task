class AddNameToOrganizations < ActiveRecord::Migration
  def change
    change_table :organizations do |t|
      t.string :name
    end
  end
end
