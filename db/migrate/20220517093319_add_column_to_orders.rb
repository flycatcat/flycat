class AddColumnToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :card_last_4_no, :string
    add_column :orders, :newebpay_amt, :integer
    add_column :orders, :status, :string
  end
end
