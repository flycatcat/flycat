# frozen_string_literal: true

class Company < ApplicationRecord
  # validates :title, presence: true, uniqueness: true
  # validates :vat_number, presence: true, uniqueness: true, length: { is: 8 }
  # validates :person_in_charge, presence: true, uniqueness: true
  # validates :address, presence: true
  # validates :contact_person, presence: true
  

  has_many :users, dependent: :destroy
  has_many :bulletins, dependent: :destroy
  has_many :departments, dependent: :destroy
  has_many :staffs, dependent: :destroy
end