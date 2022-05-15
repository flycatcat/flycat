# frozen_string_literal: true

class Department < ApplicationRecord
  include Slugable
  acts_as_paranoid
  belongs_to :company
  validates :department_name, presence: true, uniqueness: true

  def normalize_friendly_id(value)
    value.to_s.parameterize(preserve_case: true)
  end
end
