class AddAuthenticationTokenToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :auth_token, :string, default: ""
    add_index :organizations, :auth_token, unique: true
  end
end
