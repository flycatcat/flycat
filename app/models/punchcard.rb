# frozen_string_literal: true

class Punchcard < ApplicationRecord
  include Slugable
  belongs_to :user, dependent: :delete
  validates :body_temperature, presence: true
end
