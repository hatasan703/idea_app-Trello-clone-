class AddOrderToMemos < ActiveRecord::Migration[5.2]
  def change
    add_column    :memos, :position, :integer
    remove_column :memos, :row_order, :integer
  end
end
