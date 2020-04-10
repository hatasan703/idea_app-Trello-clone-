class Idea < ApplicationRecord
  require 'net/http'
  require 'uri'
  require 'json'
  before_save :create_news_query
  acts_as_list scope: :user
  belongs_to :user
  has_many :memos, ->{ order(position: :asc)  }, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one :plan

  scope :sorted, ->{ order(position: :asc)  }
  validates :content, presence: true
  def create_news_query
  end
end
