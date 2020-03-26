class Member < ApplicationRecord
  belongs_to :group
  belongs_to :user
  # belongs_to :user_types
  validates :user_id,presence: true

end
