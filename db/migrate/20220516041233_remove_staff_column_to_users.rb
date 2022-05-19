class RemoveStaffColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :title
    remove_column :users, :vat_number
    remove_column :users, :principal
    remove_column :users, :address
    remove_column :users, :contact_person
    remove_column :users, :staff_no
    remove_column :users, :name
    remove_column :users, :start_at
    remove_column :users, :job_title
    remove_column :users, :department
  end
end
