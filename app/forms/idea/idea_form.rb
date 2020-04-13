class Idea::IdeaForm
  include ActiveModel::Model
  # 検索する項目を増やす場合は下の属性に検索小目を追加
  ATTRIBUTES = %i(idea title content position open query_word user_id )
  attr_accessor(*ATTRIBUTES)

  def save
    self.query_word =create_news_query(self)
    idea = Idea.new(title:self.title ,content:self.content , user_id:self.user_id, query_word:self.query_word )
    idea.save
  end

  def create_news_query(obj_idea)
    words = URI.escape("#{obj_idea.content}")
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
    obj_idea.query_word =news_query
  end
end
##アイデア機能のビジネスロジックを分離する際に使用
