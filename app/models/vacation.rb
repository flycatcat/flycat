# frozen_string_literal: true

class Vacation < ApplicationRecord
  belongs_to :user
  belongs_to :company
  has_one :profile, through: :user
  has_one_attached :proof

  validates :vacation_at, presence: true

  include Slugable
  acts_as_paranoid

  enum vacation_type: {
    "事假": "事假",
    "病假": "病假",
    "特休": "特休",
    "婚假": "婚假",
    "產/陪產假": "產/陪產假",
    "喪假": "喪假",
    "其他(給薪)": "其他(給薪)",
    "其他(不給薪)": "其他(不給薪)"
  }

  def self.all_hour
    [
      %w[8], %w[0.5], %w[1], %w[2], %w[3], %w[4], %w[5], %w[6], %w[7]
    ]
  end

  def self.all_status
    [
      %w[Approved], %w[Rejected], %w[Pending]
    ]
  end
  STATUSES = %w[Pending Approved Rejected].freeze

  STATUSES.each do |s|
    define_method("#{s}?") { status == s }
    define_method("#{s}!") { update! status: s }

    scope s.to_sym, -> { where(status: s) }
  end

  validates :status, inclusion: { in: STATUSES }

  before_validation :set_initial_status, on: :create
  def set_initial_status
    self.status = 'Pending'
  end

  # 寄通知email
end
