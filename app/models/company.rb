# frozen_string_literal: true

class Company < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :ubn, 'taiwanese_ubn_validator/rails': true

  has_many :users, dependent: :destroy
  has_many :bulletins, dependent: :destroy
  has_many :departments, dependent: :destroy
  has_many :profiles, dependent: :destroy
  has_many :vacations
  has_many :work_shifts, dependent: :destroy
  has_many :orders
  has_one  :punchcard_setting
  
  # Callback
  after_create do
    self.create_punchcard_setting(company_address: "台北車站",latitude: 25.049270837618625,longitude: 121.51705245794972,allow_distance: 100)
  end

end
