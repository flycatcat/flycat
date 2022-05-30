# frozen_string_literal: true

class WorkShift < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :company }
  validates :kind, presence: true

  belongs_to :company
  has_many :event, dependent: :destroy

  def self.all_kind
    [
      %w[固定排班], %w[彈性排班]
    ]
  end
end
