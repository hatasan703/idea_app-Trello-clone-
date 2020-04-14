require 'rails_helper'

RSpec.describe User, type: :model do
  describe "モデル" do
    context "失敗パターン" do
      it "emailなし" do
        user = User.new(password:"password")
        user.valid?
        expect(user.errors.messages[:email]).to include("が入力されていません。")
      end
      # it "パスワード短い" do
      #   user = User.new(email:"test@primal-biz.co.jp",password:"pass")
      #   user.valid?
      #   expect(user.errors.messages[:email]).to include("が入力されていません。")
      # end
    end
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
