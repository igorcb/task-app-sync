FactoryBot.define do
  factory :task do
    title { Faker::Lorem.sentence(word_count: 3) }
    completed { false }
    external_user_name { nil }
    external_company { nil }
    external_city { nil }

    trait :completed do
      completed { true }
    end

    trait :with_external_data do
      external_user_name { "Leanne Graham" }
      external_company { "Romaguera-Crona" }
      external_city { "Gwenborough" }
    end
  end
end
