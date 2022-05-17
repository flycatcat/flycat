class AddEmailToStaffs < ActiveRecord::Migration[6.1]
  def change
    add_column :staffs, :email, :string
  end
end
