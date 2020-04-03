class Like < ApplicationRecord
  belongs_to :user
  belongs_to :idea
  scope :filter_by_idea, ->(idea_id) { where(idea_id: idea_id) if idea_id }
end
