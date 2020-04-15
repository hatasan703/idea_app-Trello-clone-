require 'rails_helper'

RSpec.describe Like, type: :model do
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
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
