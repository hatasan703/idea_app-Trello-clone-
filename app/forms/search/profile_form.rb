class Search::ProfileForm
  include ActiveModel::Model
  # 検索する項目を増やす場合は下の属性に検索小目を追加
  attr_accessor :self_introduction

  def match
    results = Profile.all
    if self.self_introduction.blank?
      results
    else
      results = results.where(['self_introduction LIKE ?', "%#{self.self_introduction}%"])
    end
  end
end
