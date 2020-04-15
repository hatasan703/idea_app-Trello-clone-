require 'rails_helper'

RSpec.describe PlanQuestion, type: :model do
  describe "モデル" do
    let(:association) do
       described_class.reflect_on_association(target)
    end
    context "アソシエーション" do
      let(:target){:plan_contents}
      it{expect(association.macro).to eq :has_many}
    end
    context "保存" do
      it "成功しかしない" do
        plan_content = PlanQuestion.new()
        expect(plan_content).to be_valid
      end

    end
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
