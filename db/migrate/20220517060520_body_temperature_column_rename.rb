class BodyTemperatureColumnRename < ActiveRecord::Migration[6.1]
  def change
    rename_column :punchcards, :boby_temperature, :body_temperature
  end
end
