class RemoveColumnFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :state, :string
    remove_column :orders, :pay_token, :string
  end
end
