class Memo < ApplicationRecord
  belongs_to :user
  belongs_to :idea
  include RankedModel
  ranks :row_order , with_same: :idea_id 
end
