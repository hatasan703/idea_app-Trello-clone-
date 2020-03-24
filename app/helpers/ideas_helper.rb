module IdeasHelper

  def get_query_word(idea_content)
    @query = URI.encode(idea_content.gsub(/[\r\n]/,""))
    @res = Hash.from_xml(open("http://jlp.yahooapis.jp/KeyphraseService/V1/extract?appid=dj00aiZpPUhhNUpvV1BUa2tMNiZzPWNvbnN1bWVyc2VjcmV0Jng9NWE-&sentence=#{@query}"))
    if @res
      @words = "(新規事業 ベンチャー スタートアップ) "
      if @res["ResultSet"]["Result"]
          @res["ResultSet"]["Result"].each.with_index do |key, index|
            if index <= 4
              begin
                @words = @words << key["Keyphrase"].to_s << " "
              rescue => error
                
              end
            end
          end
      end
    end
    @words
  end
  
end
