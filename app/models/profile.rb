# frozen_string_literal: true

class Profile < ApplicationRecord
  include Slugable
  acts_as_paranoid

  validates :staff_no, presence: true
  validates :name, presence: true
  validates :tel, presence: true
  validates :gender, presence: true
  validates :start_at, presence: true
  validates :role,  presence: true
  validates :department,  presence: true
  validates :job_title,  presence: true
  validates :email,  presence: true

  belongs_to :user
  belongs_to :company
end
