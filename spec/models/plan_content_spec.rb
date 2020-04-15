require 'rails_helper'

RSpec.describe PlanContent, type: :model do
  describe "モデル" do
    let(:association) do
       described_class.reflect_on_association(target)
    end
    context "アソシエーション" do
      let(:target){:plan}
      it{expect(association.macro).to eq :belongs_to}

      let(:target){:plan_question}
      it{expect(association.macro).to eq :belongs_to}

      let(:target){:user}
      it{expect(association.macro).to eq :belongs_to}
    end
    context "保存" do
      let(:user){build(:user)}
      let(:plan){build(:plan)}
      let(:plan_question){build(:plan_question)}
      # it "失敗" do
      #   memo = Memo.new()
      #   memo.valid?
      #   expect(memo.errors.messages[:content]).to include("が入力されていません。")
      # end
      it "成功" do
        plan_content = PlanContent.new(user:user,plan:plan,plan_question:plan_question)
        expect(plan_content).to be_valid
      end
    end
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
