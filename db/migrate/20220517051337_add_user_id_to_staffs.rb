class AddUserIdToStaffs < ActiveRecord::Migration[6.1]
  def change
    add_column :staffs, :user_id, :string
  end
end
