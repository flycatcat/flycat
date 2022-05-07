# frozen_string_literal: true

class Bulletin < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
end
