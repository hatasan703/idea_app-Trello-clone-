class AddColumnToUserType < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_types ,:user
    add_reference :members ,:user_type
  end
end
