require 'rails_helper'

RSpec.describe Memo, type: :model do
  describe "モデル" do
    let(:association) do
       described_class.reflect_on_association(target)
    end
    context "ideaに関するアソシエーション" do
      let(:target){:idea}
      it{expect(association.macro).to eq :belongs_to}
    end
    context "userに関するアソシエーション" do
      let(:target){:user}
      it{expect(association.macro).to eq :belongs_to}
    end
    context "保存" do
      let(:user){create(:user)}
      let(:company){create(:company)}
      let(:idea){create(:idea,user_id:user.id,company_id:company.id)}
      it "失敗" do
        memo = Memo.new()
        memo.valid?
        expect(memo.errors.messages[:content]).to include("が入力されていません。")
      end
      it "成功" do
        memo = Memo.new(user:user,idea:idea,content:"memo")
        expect(memo).to be_valid
      end
    end
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
