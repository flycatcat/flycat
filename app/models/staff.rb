# frozen_string_literal: true

class Staff < ApplicationRecord
  include Slugable
  belongs_to :department, optional: true

  validates :staff_no, presence: true, uniqueness: true
  validates :name, presence: true
  validates :tel, presence: true, uniqueness: true
  validates :gender, presence: true
  validates :start_at, presence: true

  def normalize_friendly_id(value)
    value.to_s.parameterize(preserve_case: true)
  end
  
  def self.all_gender
    [
      %w[男生], %w[女生]
    ]
  end
end
