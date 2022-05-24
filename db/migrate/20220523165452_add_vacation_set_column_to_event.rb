class AddVacationSetColumnToEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :vacation_set, :string
  end
end
