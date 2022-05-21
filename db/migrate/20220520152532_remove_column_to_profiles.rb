class RemoveColumnToProfiles < ActiveRecord::Migration[6.1]
  def change
    remove_column :profiles, :role
  end
end
