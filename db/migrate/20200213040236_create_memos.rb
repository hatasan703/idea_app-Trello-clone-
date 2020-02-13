class CreateMemos < ActiveRecord::Migration[5.2]
  def change
    create_table :memos do |t|
      t.text :content, null: false
      t.references :user, null: false, foreign_key: true
      t.references :idea, null: false, foreign_key: true
      t.timestamps
    end
  end
end
