class ChangeColumnOfIdeas < ActiveRecord::Migration[5.2]
  def change
    change_column :ideas, :title, :string, default:""
  end
end
