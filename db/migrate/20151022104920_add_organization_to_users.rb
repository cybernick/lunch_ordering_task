class AddOrganizationToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.belongs_to :organization
    end
  end
end
