class Memo < ApplicationRecord
  belongs_to :user
  belongs_to :idea
  # belongs_to :idea, inverse_of: :children
end
