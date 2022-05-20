FactoryBot.define do
  factory :punchcard do
    punch_in_at { "2022-05-17 12:17:37" }
    punch_out_at { "2022-05-17 12:17:37" }
    boby_temperature { "9.99" }
    is_punched_in_today { false }
    users { nil }
  end
end
