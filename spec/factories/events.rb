FactoryBot.define do
  factory :event do
    all_day { false }
    start_time { "2022-05-19 06:13:18" }
    end_time { "2022-05-19 06:13:18" }
    title { "MyString" }
    content { "MyString" }
    date { "2022-05-19" }
    work_shift { nil }
  end
end
