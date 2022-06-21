# frozen_string_literal: true

class Profile < ApplicationRecord
  include Slugable

  validates :staff_no, presence: true, uniqueness: { scope: :company }
  validates :name, presence: true
  validates :tel, presence: true, length: { maximum: 10 }
  validates :gender, presence: true
  validates :start_at, presence: true
  validates :department, presence: true
  validates :job_title, presence: true

  belongs_to :user, dependent: :delete
  belongs_to :company

  def self.to_csv(fields = column_names, options={})
    CSV.generate(options) do |csv|
      csv << fields
      all.each do |profiles|
        csv << profiles.attributes.values_at(*fields)
      end
    end
  end
end
