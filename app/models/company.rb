# frozen_string_literal: true

class Company < ApplicationRecord
  validates :company_title, presence: true, uniqueness: true
  validates :vat_number, presence: true, uniqueness: true, length: { is: 8 }
  validates :principal, presence: true, uniqueness: true
  validates :address, presence: true
  validates :linkman, presence: true
  validates :email, presence: true
end
