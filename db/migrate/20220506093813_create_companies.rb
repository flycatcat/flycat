# frozen_string_literal: true

class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :company_title
      t.string :vat_number
      t.string :principal
      t.string :address
      t.string :linkman
      t.string :email

      t.timestamps
    end
  end
end
