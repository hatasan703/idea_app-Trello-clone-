class AddOrderToMemos < ActiveRecord::Migration[5.2]
  def change
    add_column    :memos, :position, :integer
  end
end
