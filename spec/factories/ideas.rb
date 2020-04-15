FactoryBot.define do
  factory :idea do
    sequence(:content,"test")
    association :user
    association :company
  end
end
