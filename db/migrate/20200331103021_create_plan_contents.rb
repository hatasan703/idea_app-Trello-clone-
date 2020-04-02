class CreatePlanContents < ActiveRecord::Migration[5.2]
  def change
    create_table :plan_contents do |t|
      t.text :content, null: false
      t.references :user, null: false, foreign_key: true
      t.references :plan, null: false, foreign_key: true
      t.references :plan_question, null: false, foreign_key: true
      t.timestamps
    end
  end
end
