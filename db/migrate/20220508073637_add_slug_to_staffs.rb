class AddSlugToStaffs < ActiveRecord::Migration[7.0]
  def change
    add_column :staffs, :slug, :string
    add_index :staffs, :slug, unique: true
  end
end
