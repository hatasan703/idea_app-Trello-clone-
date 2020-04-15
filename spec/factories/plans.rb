FactoryBot.define do
  factory :plan do
    association :user
    association :idea
  end
end
