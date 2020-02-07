class CreateIdeaMemos < ActiveRecord::Migration[5.2]
  def change
    create_table :idea_memos do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.references :user, null: false, foreign_key: true
      t.references :idea, null: false, foreign_key: true
      t.timestamps
    end
  end
end
