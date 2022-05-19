class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :order_no
      t.string :username
      t.integer :amount
      t.string :transaction_no
      t.text :memo
      t.string :pay_type
      t.datetime :pay_at
      t.string :card_last_4_no
      t.integer :newebpay_amt
      t.string :status

      t.timestamps
    end
  end
end
