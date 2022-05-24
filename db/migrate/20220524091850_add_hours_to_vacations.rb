class AddHoursToVacations < ActiveRecord::Migration[6.1]
  def change
    add_column :vacations, :hour, :integer
  end
end
