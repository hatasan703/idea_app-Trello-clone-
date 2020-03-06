class Idea < ApplicationRecord
  acts_as_list
  belongs_to :user
  has_many :memos, ->{ order(position: :asc)  }, dependent: :destroy
  has_many :comments
  has_one :pran

  scope :sorted, ->{ order(position: :asc)  }
  validates :content, presence: true



end