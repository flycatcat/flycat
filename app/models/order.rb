# frozen_string_literal: true

class Order < ApplicationRecord
  validates :username, presence: true
  validates :amount, presence: true
  validates :order_no, uniqueness: true

  before_create :flycatOrderNo

  private

  def flycatOrderNo
    flycat = "flycat#{Time.current.strftime('%Y%m%d%H%M%w')}"
    random = [*'a'..'z', *'A'..'Z', *'0'..'9']
    self.order_no = flycat + random.sample(7).join
  end
end
