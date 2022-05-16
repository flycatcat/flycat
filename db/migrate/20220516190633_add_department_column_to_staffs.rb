class AddDepartmentColumnToStaffs < ActiveRecord::Migration[6.1]
  def change
    add_column :staffs, :department, :string
  end
end
