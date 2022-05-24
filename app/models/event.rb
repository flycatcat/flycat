class Event < ApplicationRecord
  validates :start_time, :end_time, presence: true
  validates :title, presence: true
  validate :end_time_after_start_time

  belongs_to :work_shift

  def self.all_vacation_set
    [
      %w[工作日], %w[休假日], %w[例假日], %w[國定假日]
    ]
  end

  private

  def end_time_after_start_time
    if end_time <= start_time
      errors.add(:end_time, "必須大於開始時間")
    end
 end
end
