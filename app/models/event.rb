# frozen_string_literal: true

class Event < ApplicationRecord
  validates :start_at, :end_at, presence: true
  validates :title, presence: true
  validate :end_at_after_start_at

  belongs_to :work_shift

  def self.all_vacation_set
    [
      %w[工作日], %w[休假日], %w[例假日], %w[國定假日]
    ]
  end

  def self.all_mode
    [
      %w[一般], %w[循環例假], %w[循環工作], %w[清空]
    ]
  end

  private

  def end_at_after_start_at
    if end_at <= start_at
      errors.add(:end_at, "必須大於開始時間")
    end
  end
end
