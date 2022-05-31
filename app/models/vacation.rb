# frozen_string_literal: true

class Vacation < ApplicationRecord
  belongs_to :user, dependent: :delete
  belongs_to :company
  has_one :profile, through: :user, dependent: :delete
  has_one_attached :proof
  validates :vacation_at, presence: true
  before_validation :set_initial_status, on: :create

  include Slugable
  acts_as_paranoid

  enum vacation_type: {
    '事假': '事假',
    '病假': '病假',
    '特休': '特休',
    '婚假': '婚假',
    '產/陪產假': '產/陪產假',
    '喪假': '喪假',
    '其他(給薪)': '其他(給薪)',
    '其他(不給薪)': '其他(不給薪)'
  }

  enum vacation_status: {
      '待簽核': 'pending',
      '同意': 'approved',
      '駁回': 'rejected',
    }

  STATUSES = %w[pending approved rejected].freeze

  STATUSES.each do |s|
    define_method("#{s}?") { status == s }
    define_method("#{s}!") { update! status: s }

    scope s.to_sym, -> { where(status: s) }
  end

  validates :status, inclusion: { in: STATUSES }
  
  def set_initial_status
    self.status = 'pending'
  end

end