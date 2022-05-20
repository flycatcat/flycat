class ColumnRenameInPunchcard < ActiveRecord::Migration[6.1]
  def change
    rename_column :punchcards, :users_id, :user_id
  end
end
