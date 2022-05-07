# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    company_title { 'MyString' }
    vat_number { 'MyString' }
    principal { 'MyString' }
    address { 'MyString' }
    linkman { 'MyString' }
    email { 'MyString' }
  end
end
