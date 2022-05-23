class Vacation < ApplicationRecord
  belongs_to :user
  belongs_to :company
  acts_as_paranoid
  validates :vacation_at, presence: true

  def self.all_type
    [
      %w[事假半天], %w[事假全天], %w[病假半天], %w[病假全天], %w[特休半天], %w[特休全天], %w[婚假], %w[產/陪產假 ],%w[喪假], %w[其他(給薪)], %w[其他(不給薪)]
    ]
  end
  STATUSES = %w[pending approved rejected].freeze

  STATUSES.each do |s|
    define_method("#{s}?") { status == s}
    define_method("#{s}!") { update! status: s }

    scope s.to_sym, -> { where(status: s) }
  end

  validates :status, inclusion: { in: STATUSES }

  before_validation :set_initial_status, on: :create
  def set_initial_status
    self.status = "pending"
  end

    #寄通知email 
end
