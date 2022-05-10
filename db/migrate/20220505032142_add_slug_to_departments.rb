# frozen_string_literal: true

class AddSlugToDepartments < ActiveRecord::Migration[6.1]
  def change
    add_column :departments, :slug, :string
    add_index :departments, :slug, unique: true
  end
end
