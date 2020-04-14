require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe "モデル" do
    let(:association) do
       described_class.reflect_on_association(target)
    end
    context "アソシエーション" do
      let(:target){:company}
      it{expect(association.macro).to eq :belongs_to}

      let(:target){:user}
      it{expect(association.macro).to eq :belongs_to}
    end
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
