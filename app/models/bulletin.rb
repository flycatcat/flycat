# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include Slugable
  validates :title, presence: true
  validates :content, presence: true
  belongs_to :company
end
