# frozen_string_literal: true

FactoryBot.define do
  factory :staff do
    staff_no { 'MyString' }
    name { 'MyString' }
    tel { 'MyString' }
    gender { 'MyString' }
    start_at { '2022-05-03' }
    department { nil }
  end
end
