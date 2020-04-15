class Idea < ApplicationRecord
  require 'net/http'
  require 'uri'
  require 'json'
  before_save :create_news_query
  acts_as_list scope: :user
  acts_as_list scope: :company
  belongs_to :user
  belongs_to :company
  has_many :memos, ->{ order(position: :asc)  }, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one :plan

  scope :sorted, ->{ order(position: :asc)  }
  validates :content, presence: true
  def create_news_query
    words = URI.escape("#{self.content}")
    uri = URI.parse("https://jlp.yahooapis.jp/KeyphraseService/V1/extract?appid=dj00aiZpPWMwNFNqT2g0NGlNRiZzPWNvbnN1bWVyc2VjcmV0Jng9MzI-&sentence=#{words}&output=json")
    response = Net::HTTP.get_response(uri)
    hsh =JSON.parse(response.body)
    news_query = ""
    count =0
    hsh.each_key do |k|
      news_query +="#{k}"
      count +=1
      break if count==3
      news_query +="+"
    end
    self.query_word =news_query
  end
end
