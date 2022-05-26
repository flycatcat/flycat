# frozen_string_literal: true

class Vacation < ApplicationRecord
  belongs_to :user
  belongs_to :company

  validates :vacation_at, presence: true

  include Slugable
  acts_as_paranoid

  has_one_attached :proof

  def self.all_type
    [
      %w[事假], %w[病假], %w[特休], %w[婚假], %w[產/陪產假], %w[喪假], %w[其他(給薪)], %w[其他(不給薪)]
    ]
  end

  def self.all_hour
    [
      %w[8], %w[0.5]
    ]
  end

  def self.all_status
    [
      %w[approved], %w[rejected]
    ]
  end
  STATUSES = %w[pending approved rejected].freeze

  STATUSES.each do |s|
    define_method("#{s}?") { status == s }
    define_method("#{s}!") { update! status: s }

    scope s.to_sym, -> { where(status: s) }
  end

  validates :status, inclusion: { in: STATUSES }

  before_validation :set_initial_status, on: :create
  def set_initial_status
    self.status = 'pending'
  end

  # 寄通知email
end
