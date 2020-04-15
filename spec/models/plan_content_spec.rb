require 'rails_helper'

RSpec.describe PlanContent, type: :model do
  describe "モデル" do
    let(:association) do
       described_class.reflect_on_association(target)
    end
    context "planに関するアソシエーション" do
      let(:target){:plan}
      it{expect(association.macro).to eq :belongs_to}
    end
    context "plan_questionに関するアソシエーション"do
      let(:target){:plan_question}
      it{expect(association.macro).to eq :belongs_to}
    end
    context "userに関するアソシエーション" do
      let(:target){:user}
      it{expect(association.macro).to eq :belongs_to}
    end
    context "保存" do
      let(:user){build(:user)}
      let(:plan){build(:plan)}
      let(:plan_question){build(:plan_question)}
      it "成功" do
        plan_content = PlanContent.new(user:user,plan:plan,plan_question:plan_question)
        expect(plan_content).to be_valid
      end

      it "失敗" do
        plan_content = PlanContent.new()
        plan_content.valid?
        expect(plan_content.errors.messages[:user]).to include("を入力してください")
        expect(plan_content.errors.messages[:plan]).to include("を入力してください")
        expect(plan_content.errors.messages[:plan_question]).to include("を入力してください")
      end
    end
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
