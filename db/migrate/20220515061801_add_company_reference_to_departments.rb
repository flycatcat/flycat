class AddCompanyReferenceToDepartments < ActiveRecord::Migration[6.1]
  def change
    add_reference :departments, :company, foreign_key: true
  end
end
