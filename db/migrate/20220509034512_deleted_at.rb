class DeletedAt < ActiveRecord::Migration[6.1]
  def change
    add_column :bulletins, :deleted_at, :datetime
    add_column :staffs, :deleted_at, :datetime
    add_column :departments, :deleted_at, :datetime
  end
end
