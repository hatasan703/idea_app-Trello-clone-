require 'rails_helper'

RSpec.describe Idea, type: :model do
  it " 保存に成功するか" do
    user = create(:user)
    ideas = Idea.new(user_id:user.id,content:"新規事業とは？")
    expect(ideas).to be_valid
  end

  it "バリデーションが効くか" do
    ideas = Idea.new()
    ideas.valid?
    expect(ideas.errors.messages[:content]).to include("can't be blank")
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
