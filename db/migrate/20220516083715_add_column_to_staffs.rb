class AddColumnToStaffs < ActiveRecord::Migration[6.1]
  def change
    add_column :staffs, :role, :string
  end
end
