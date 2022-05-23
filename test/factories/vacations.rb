# frozen_string_literal: true

FactoryBot.define do
  factory :vacation do
    vacation_type { 'MyString' }
    vacation_at { 'MyString' }
    date { 'MyString' }
    status { 'MyString' }
    reason { 'MyString' }
    user { nil }
    company { nil }
  end
end
