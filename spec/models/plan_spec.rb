require 'rails_helper'

RSpec.describe Plan, type: :model do
  describe "モデル" do
    let(:association) do
      described_class.reflect_on_association(target)
    end
    context "userに関するアソシエーション" do
      let(:target){:user}
      it{expect(association.macro).to eq :belongs_to}
    end
    context "ideaに関するアソシエーション" do
      let(:target){:idea}
      it{expect(association.macro).to eq :belongs_to}
    end
    context "plan_contentsに関するアソシエーション" do
      let(:target){:plan_contents}
      it{expect(association.macro).to eq :has_many}
    end
    context "保存" do
      let(:user){build(:user)}
      let(:idea){build(:idea)}
      it "成功" do
        plan = Plan.new(user:user,idea:idea)
        expect(plan).to be_valid
      end

      it "失敗" do
        plan_content = Plan.new()
        plan_content.valid?
        expect(plan_content.errors.messages[:user]).to include("を入力してください")
        expect(plan_content.errors.messages[:idea]).to include("を入力してください")
      end
    end
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
