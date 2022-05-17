class SetfefaultColumn < ActiveRecord::Migration[6.1]
  def change
    change_column :punchcard, :is_first_punchcard_today, boolean, default: true

  end
end
