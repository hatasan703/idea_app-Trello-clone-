class CreateUserTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :user_types do |t|
      t.integer :user_right ,default:0
      t.timestamps
    end
  end
end
