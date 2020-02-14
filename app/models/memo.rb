class Memo < ApplicationRecord
  belongs_to :user
  belongs_to :idea
  # acts_as_list scope: :idea
  include RankedModel
  ranks :row_order
end
