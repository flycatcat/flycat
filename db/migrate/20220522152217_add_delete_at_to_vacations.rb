class AddDeleteAtToVacations < ActiveRecord::Migration[6.1]
  def change
    add_column :vacations, :deleted_at, :datetime
  end
end
