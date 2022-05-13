FactoryBot.define do
  factory :answer do
    body { "AnswerBodyTest" }

    trait :invalid do
      body { nil }
    end

    association :question
    association :user
  end
end
