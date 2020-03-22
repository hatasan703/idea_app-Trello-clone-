class AddColumnIdeas < ActiveRecord::Migration[5.2]
  def change
    add_column :ideas, :open, :boolean, default: false
  end
end
