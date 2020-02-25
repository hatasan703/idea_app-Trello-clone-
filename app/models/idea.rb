class Idea < ApplicationRecord
  belongs_to :user
  has_many :memos, dependent: :destroy
  has_many :comments
  has_one :pran

  accepts_nested_attributes_for :memos, allow_destroy: true
end