class UsersChange < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :company_id, :references, null: false, foreign_key: true
    remove_column :users, :user_number, :integer, null: false
    remove_column :users, :user_name, :string, null: false
  end
end
