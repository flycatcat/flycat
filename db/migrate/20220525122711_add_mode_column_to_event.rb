class AddModeColumnToEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :mode, :string
  end
end
