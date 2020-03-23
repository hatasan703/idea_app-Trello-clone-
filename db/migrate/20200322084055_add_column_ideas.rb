class AddColumnIdeas < ActiveRecord::Migration[5.2]
  def change
    add_column :ideas, :open, :boolean, default: false
    add_column :ideas, :query_word, :string
  end
end
