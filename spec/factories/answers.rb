FactoryBot.define do
  factory :answer do
    body { "Answer body test" }

    trait :invalid do
      body { nil }
    end

    association :question
  end
end
