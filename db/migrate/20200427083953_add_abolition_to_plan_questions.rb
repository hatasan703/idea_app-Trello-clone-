class AddAbolitionToPlanQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :plan_questions, :abolition, :boolean, default: false
  end
end
