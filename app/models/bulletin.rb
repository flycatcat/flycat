# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include Slugable
  acts_as_paranoid
  validates :title, presence: true
  validates :content, presence: true
  belongs_to :company
end
