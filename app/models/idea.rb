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
  has_many :idea_members, dependent: :destroy
  has_many :users, through: :idea_members
  has_one :plan, dependent: :destroy

  scope :sorted, ->{ order(position: :asc)  }
  scope :filter_by_self, ->(current_user) { where(user_id: current_user.id)  }
  scope :opened, ->{ where(open: true).order(created_at: "DESC")  }
  scope :filter_by_company, ->(company_id) { where(company_id: company_id)  }

  
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

  def admin_user?(current_user)
    if current_user.employees.find(self.company_id).admin == true
      true
    else
      false
    end
  end
end
