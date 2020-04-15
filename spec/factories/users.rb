FactoryBot.define do
  factory :user do
    sequence(:name,"abcdefg")
    sequence(:email,"test@primal-biz.co.jp")
    sequence(:password,"password")
  end
end
