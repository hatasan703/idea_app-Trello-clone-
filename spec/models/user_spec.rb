require 'rails_helper'

RSpec.describe User, type: :model do
  describe "モデル" do
    let(:association) do
       described_class.reflect_on_association(target)
    end
    ### has_manyアソシエーション###
    context "memo" do
      let(:target) { :ideas }
      it "アソシエーション" do
        expect(association.macro).to eq :has_many
      end
    end
    context "comment" do
      let(:target) { :comments }
      it "アソシエーション" do
        expect(association.macro).to eq :has_many
      end
    end
    context "like" do
      let(:target) { :likes }
      it "アソシエーション" do
        expect(association.macro).to eq :has_many
      end
    end
    context "memo" do
      let(:target) { :memos }
      it "アソシエーション" do
        expect(association.macro).to eq :has_many
      end
    end
    context "member" do
      let(:target) { :members }
      it "アソシエーション" do
        expect(association.macro).to eq :has_many
      end
    end
    context "group" do
      let(:target) { :groups }
      it "アソシエーション" do
        expect(association.macro).to eq :has_many
      end
    end
    context "employee" do
      let(:target) { :employees }
      it "アソシエーション" do
        expect(association.macro).to eq :has_many
      end
    end
    context "company" do
      let(:target) { :companies }
      it "アソシエーション" do
        expect(association.macro).to eq :has_many
      end
    end
    #############
    ### has_one アソシエーション ###
    context "profile" do
      let(:target) { :profile }
      it "アソシエーション" do
        expect(association.macro).to eq :has_one
      end
    end
    #################
    context "失敗パターン" do
      it "emailなし" do
        user = User.new(password:"password")
        user.valid?
        expect(user.errors.messages[:email]).to include("が入力されていません。")
      end
      it "パスワード短い" do
        user = User.new(email:"test@primal-biz.co.jp",password:"pass")
        user.valid?
        expect(user.errors.messages[:password]).to include("は6文字以上に設定して下さい。")
      end
    end
    context "成功パターン" do
      it "普通に成功" do
        user = User.new(email:"test0@primal-biz.co.jp",password:"password")
        user.valid?
        expect(user).to be_valid
      end
    end
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
