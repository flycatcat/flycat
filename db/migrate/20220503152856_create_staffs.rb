class CreateStaffs < ActiveRecord::Migration[6.1]
  def change
    create_table :staffs do |t|
      t.string :staff_no
      t.string :name
      t.string :tel
      t.string :gender
      t.date :start_at
      t.belongs_to :department, null: false, foreign_key: true

      t.timestamps
    end
  end
end
