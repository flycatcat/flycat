class ChangeColumnToStaffs < ActiveRecord::Migration[6.1]
  def change
    remove_column :staffs, :user_id
    add_reference :staffs, :user, foreign_key: true
  end
end
