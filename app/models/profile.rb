# frozen_string_literal: true

class Profile < ApplicationRecord
  include Slugable

  validates :staff_no, presence: true, uniqueness: { scope: :company }
  validates :name, presence: true
  validates :tel, presence: true
  validates :gender, presence: true
  validates :start_at, presence: true
  validates :department, presence: true
  validates :job_title, presence: true
  validates :email, presence: true

  belongs_to :user, dependent: :delete
  belongs_to :company
end
