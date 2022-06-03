class AddColumnToOrders < ActiveRecord::Migration[6.1]
    def change
      add_column :orders, :company_id, :string
    end
end
