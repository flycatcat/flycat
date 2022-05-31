# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include Slugable
  acts_as_paranoid
  validates :title, presence: true
  validates :content, presence: true
  belongs_to :company
  has_many :bulletin_reads
  has_many :read_bulletins, through: :bulletin_reads
end
