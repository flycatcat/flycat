# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    order_no { 'MyString' }
    username { 'MyString' }
    amount { 1 }
    transaction_no { 'MyString' }
    memo { 'MyText' }
    pay_type { 'MyString' }
    pay_at { '2022-05-19 23:42:05' }
    card_last_4_no { 'MyString' }
    newebpay_amt { 1 }
    status { 'MyString' }
  end
end
