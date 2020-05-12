class CreateIdeaMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :idea_members do |t|
      t.references :idea, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
