class AddCompanyIdToStaffs < ActiveRecord::Migration[6.1]
  def change
    add_reference :staffs, :company, foreign_key: true
  end
end
