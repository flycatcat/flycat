class ChangeColumnToCompanies < ActiveRecord::Migration[6.1]
  def change
    rename_column :companies, :company_title, :title
    rename_column :companies, :linkman, :contact_person
    rename_column :companies, :principal, :person_in_charge
    remove_column :companies, :email
  end
end
