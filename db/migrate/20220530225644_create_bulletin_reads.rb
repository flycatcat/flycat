class CreateBulletinReads < ActiveRecord::Migration[6.1]
  def change
    create_table :bulletin_reads do |t|
      t.boolean :is_read, default: false
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :bulletin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
