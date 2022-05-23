# frozen_string_literal: true

class Department < ApplicationRecord
  include Slugable
  acts_as_paranoid

  belongs_to :company

  validates :department_name, presence: true, uniqueness: { scope: :company }
end
