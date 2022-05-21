# frozen_string_literal: true

class Company < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :ubn, 'taiwanese_ubn_validator/rails': true

  has_many :users, dependent: :destroy
  has_many :bulletins, dependent: :destroy
  has_many :departments, dependent: :destroy
  has_many :profiles, dependent: :destroy

end
