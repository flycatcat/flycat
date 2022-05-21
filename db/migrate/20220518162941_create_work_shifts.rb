class CreateWorkShifts < ActiveRecord::Migration[6.1]
  def change
    create_table :work_shifts do |t|
      t.string :title
      t.string :kind
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
