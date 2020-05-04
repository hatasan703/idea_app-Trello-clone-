class CreatePlanComments < ActiveRecord::Migration[5.2]
  def change
    create_table :plan_comments do |t|
      t.text :content, null: false
      t.references :user, null: false, foreign_key: true
      t.references :plan, null: false, foreign_key: true
      t.timestamps
    end
  end
end
