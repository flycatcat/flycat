# frozen_string_literal: true

class Order < ApplicationRecord
  validates :username, presence: true
  validates :amount, presence: true
  validates :order_no, uniqueness: true
  belongs_to :company

  before_create :flycatOrderNo

  private

  def flycatOrderNo
    self.order_no = "flycat#{Time.current.strftime('%Y%m%d')}#{SecureRandom.alphanumeric(7)}"
  end
end
