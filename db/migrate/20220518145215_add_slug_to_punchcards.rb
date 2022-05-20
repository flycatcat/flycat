class AddSlugToPunchcards < ActiveRecord::Migration[6.1]
  def change
    add_column :punchcards, :slug, :string
  end
end
