class PlanContent < ApplicationRecord
  belongs_to :user
  belongs_to :plan
  belongs_to :plan_question
end
