class RemvoeGenderTelColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :tel
    remove_column :users, :gender
  end
end
