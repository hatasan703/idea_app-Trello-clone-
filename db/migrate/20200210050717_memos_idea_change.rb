class MemosIdeaChange < ActiveRecord::Migration[5.2]
  def change
    remove_column :idea_memos, :title, :string, null: false
  end
end
