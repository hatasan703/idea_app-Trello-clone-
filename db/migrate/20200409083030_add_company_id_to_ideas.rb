class AddCompanyIdToIdeas < ActiveRecord::Migration[5.2]
  def change
    add_reference :ideas, :company, foreign_key: true, null: false
  end
end
