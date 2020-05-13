class IdeaMember < ApplicationRecord
  belongs_to :idea
  belongs_to :user
  scope :filter_by_idea, ->(idea_id) { where(idea_id: idea_id) if idea_id }
end
