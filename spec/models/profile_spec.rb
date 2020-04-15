require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe "モデル" do
    let(:association) do
      described_class.reflect_on_association(target)
    end
    context "userに関するアソシエーション" do
      let(:target){:user}
      it{expect(association.macro).to eq :belongs_to}
    end
    context "保存" do
      let(:user){build(:user)}
      it "成功" do
        profile = Profile.new(user:user)
        expect(profile).to be_valid
      end

      it "失敗" do
        profile = Profile.new()
        profile.valid?
        expect(profile.errors.messages[:user]).to include("を入力してください")
      end
    end
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
