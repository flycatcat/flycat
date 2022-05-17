class CreatePunchcards < ActiveRecord::Migration[6.1]
  def change
    create_table :punchcards do |t|
      t.datetime :punch_in_at
      t.datetime :punch_out_at
      t.decimal :boby_temperature
      t.boolean :is_punched_in_today
      t.references :users, null: false, foreign_key: true

      t.timestamps
    end
  end
end
