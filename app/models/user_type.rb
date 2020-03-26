class UserType < ApplicationRecord
  belongs_to :user
  enum user_right:{ admin: 0, normal: 1, invited: 2 }
  has_many :members
  has_many :groups ,through: :members
end
