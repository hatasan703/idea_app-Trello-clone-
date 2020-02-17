class AddRowOrderToMemos < ActiveRecord::Migration[5.2]
  def change
    add_column :memos, :row_order, :integer
  end
end
