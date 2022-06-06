class AddOnDutyStaffToEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :on_duty_staff, :string
  end
end
