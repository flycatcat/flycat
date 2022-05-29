class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.boolean :all_day
      t.datetime :start_time
      t.datetime :end_time
      t.string :title
      t.string :content
      t.date :date
      t.references :work_shift, null: false, foreign_key: true

      t.timestamps
    end
  end
end
