class RenameStaffsTable < ActiveRecord::Migration[6.1]
  def change
    rename_table :staffs , :profiles
  end
end
