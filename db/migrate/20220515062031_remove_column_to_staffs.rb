class RemoveColumnToStaffs < ActiveRecord::Migration[6.1]
  def change
    remove_column :staffs, :department_id
  end
end
