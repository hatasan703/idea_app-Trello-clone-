class Idea < ApplicationRecord
  belongs_to :user
  has_many :idea_memos
  has_many :comments
  has_one :pran
end
