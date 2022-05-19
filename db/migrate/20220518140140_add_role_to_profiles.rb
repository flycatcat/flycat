class AddRoleToProfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :role, :string
  end
end
