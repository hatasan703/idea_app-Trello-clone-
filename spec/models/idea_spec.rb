require 'rails_helper'

RSpec.describe Idea, type: :model do
  describe "モデル" do
    before do
      @user = create(:user)
    end
    let(:association) do
       described_class.reflect_on_association(target)
    end
    ### has_manyアソシエーション###
    context "memo" do
      let(:target) { :memos }
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
    #############################
    ### belongs_to アソシエーション###
    context "user" do
      let(:target) { :user }
      it "アソシエーション" do
        expect(association.macro).to eq :belongs_to
      end
    end
    ################################
    ### has_one アソシエーション ###
    context "plan" do
      let(:target) { :plan }
      it "アソシエーション" do
        expect(association.macro).to eq :has_one
      end
    end
    ###############################
    context "保存の際" do
      it " 成功するか" do
        ideas = Idea.new(user_id:@user.id,content:"新規事業とは？")
        expect(ideas).to be_valid
      end
      it "バリデーションが効くか" do
        ideas = Idea.new()
        ideas.valid?
        expect(ideas.errors.messages[:content]).to include("が入力されていません。")
      end
    end
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
