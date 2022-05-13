FactoryBot.define do
  factory :question do
    title { "QuestionTitleTest" }
    body { "QuestionBodyTest" }

    trait :invalid do
      title { nil }
    end

    trait :with_answers do
      transient { count { 2 } }
      after(:build) { |question, evaluator| create_list(:answer, evaluator.count, question: question) }
    end

    association :user
  end
end
