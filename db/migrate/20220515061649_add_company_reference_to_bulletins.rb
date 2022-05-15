class AddCompanyReferenceToBulletins < ActiveRecord::Migration[6.1]
  def change
    add_reference :bulletins, :company, foreign_key: true
  end
end
