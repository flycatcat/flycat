# frozen_string_literal: true

class Order < ApplicationRecord
  validates :username, presence: true
  validates :amount, presence: true
end
