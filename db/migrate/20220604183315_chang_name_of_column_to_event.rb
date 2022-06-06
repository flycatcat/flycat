class ChangNameOfColumnToEvent < ActiveRecord::Migration[6.1]
  def change
    rename_column :events, :start_time, :start_at
    rename_column :events, :end_time, :end_at
    rename_column :events, :mode, :shifted_mode
    remove_column :events, :date
  end
end
