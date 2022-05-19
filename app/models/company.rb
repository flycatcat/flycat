# frozen_string_literal: true

class Company < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :vat_number, presence: true, uniqueness: true, length: { is: 8 }

  has_many :users, dependent: :destroy
  has_many :bulletins, dependent: :destroy
  has_many :departments, dependent: :destroy
  has_many :profiles, dependent: :destroy

  def after_sign_in_path_for(_resource)
    root_path
  end
end
