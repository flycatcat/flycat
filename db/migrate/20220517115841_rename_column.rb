class RenameColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :punchcards, :is_punched_in_today, :is_first_punchcard_today
  end
end
