class WorkShift < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :company }
  validates :kind, presence: true

  belongs_to :company
  has_many :event, dependent: :destroy
end
