class ChangeColumnToVacations < ActiveRecord::Migration[6.1]
  def change
    change_column :vacations, :hour, :decimal
  end
end
