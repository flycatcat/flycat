class AddJobTitleToStaffs < ActiveRecord::Migration[6.1]
  def change
    add_column :staffs, :job_title, :string
  end
end
