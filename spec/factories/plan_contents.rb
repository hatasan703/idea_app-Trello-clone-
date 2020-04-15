FactoryBot.define do
  factory :plan_content do
    association :user
    association :idea
    association :plan_question
  end
end
