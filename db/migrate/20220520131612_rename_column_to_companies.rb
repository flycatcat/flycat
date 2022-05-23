class RenameColumnToCompanies < ActiveRecord::Migration[6.1]
  def change
    rename_column :companies, :vat_number, :ubn
  end
end
