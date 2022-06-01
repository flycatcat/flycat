class UpdateForeignKeyToVacations < ActiveRecord::Migration[6.1]
  def change
        remove_foreign_key :vacations, :users
        add_foreign_key :vacations, :users, on_delete: :cascade
  end
end
