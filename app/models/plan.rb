class Plan < ApplicationRecord
  belongs_to :user
  belongs_to :idea
  belongs_to :plan_question
end
