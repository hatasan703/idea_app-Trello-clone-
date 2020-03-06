class AddOrderToIdeas < ActiveRecord::Migration[5.2]
  def change
    add_column    :ideas, :position, :integer
    remove_column :ideas, :title, :string
  end
end
