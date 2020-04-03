class AddOrderToIdeas < ActiveRecord::Migration[5.2]
  def change
    add_column    :ideas, :position, :integer
  end
end
