class ChangeColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :company_id, :string, foreign_key: true
    add_column :users, :title, :string
    add_column :users, :vat_number, :integer
    add_column :users, :principal, :string
    add_column :users, :address, :string
    add_column :users, :contact_person, :string
    add_column :users, :staff_no, :integer
    add_column :users, :name, :string
    add_column :users, :start_at, :date
    add_column :users, :job_title, :string
    add_column :users, :department, :string

    change_column_default :users, :role, 'admin'
    
  end
end
