class IdeaMember < ApplicationRecord
  belongs_to :idea
  belongs_to :user
end
