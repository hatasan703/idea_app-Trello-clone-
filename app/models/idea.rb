class Idea < ApplicationRecord
  acts_as_list scope: :user
  belongs_to :user
  has_many :memos, ->{ order(position: :asc)  }, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :pran

  scope :sorted, ->{ order(position: :asc)  }
  validates :content, presence: true



end