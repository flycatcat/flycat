class AddSlugToBulletins < ActiveRecord::Migration[6.1]
  def change
    add_column :bulletins, :slug, :string
    add_index :bulletins, :slug, unique: true
  end
end
