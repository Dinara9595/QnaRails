FactoryBot.define do
  sequence :body do |n|
    "AnswerBodyTest#{n}"
  end

  factory :answer do
    body

    trait :invalid do
      body { nil }
    end

    association :question
    association :user
  end
end
