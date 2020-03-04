class Memo < ApplicationRecord
  acts_as_list scope: :idea

  belongs_to :user
  belongs_to :idea

  validates :content, presence: true
end
