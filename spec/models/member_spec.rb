require 'rails_helper'

RSpec.describe Member, type: :model do
  describe "モデル" do
    let!(:group){build(:group)}
    let!(:user){build(:user)}
    let(:association) do
       described_class.reflect_on_association(target)
    end
    context "groupに関するアソシエーション" do
      let(:target){:group}
      it{expect(association.macro).to eq :belongs_to}
    end
    context "userに関するアソシエーション" do
      let(:target){:user}
      it{expect(association.macro).to eq :belongs_to}
    end
    context "保存" do
      let(:user){create(:user)}
      let(:group){create(:group)}
      it "失敗" do
        members = Member.new()
        members.valid?
        expect(members.errors.messages[:user_id]).to include("が入力されていません。")
        expect(members.errors.messages[:group_id]).to include("が入力されていません。")
      end
      it "成功" do
        members = Member.new(group:group,user:user)
        expect(members).to be_valid
      end
    end
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
