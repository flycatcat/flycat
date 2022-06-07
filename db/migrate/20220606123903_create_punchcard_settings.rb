class CreatePunchcardSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :punchcard_settings do |t|
      t.string :company_address
      t.decimal :latitude
      t.decimal :longitude
      t.integer :allow_distance
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
