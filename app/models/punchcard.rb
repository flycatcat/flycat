# frozen_string_literal: true

class Punchcard < ApplicationRecord
  include Slugable
  belongs_to :user
  validates :body_temperature, presence: true

  # # Callback
  # after_create do
  #   update(first_punch: false)
  # end
end
