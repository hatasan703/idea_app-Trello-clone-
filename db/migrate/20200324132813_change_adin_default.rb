class ChangeAdinDefault < ActiveRecord::Migration[5.2]
  def change
    change_column :members, :admin,:boolean, default: false
    change_column :members, :activate,:boolean, default: false
  end
end
