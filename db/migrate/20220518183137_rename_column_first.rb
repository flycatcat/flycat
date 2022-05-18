class RenameColumnFirst < ActiveRecord::Migration[6.1]
  def change
    rename_column :punchcards, :is_first_punchcard_today, :first_punch
  end
end
