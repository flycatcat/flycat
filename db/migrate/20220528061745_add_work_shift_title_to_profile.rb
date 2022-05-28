class AddWorkShiftTitleToProfile < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :work_shift_title, :string
  end
end
