class CreateInvitingManagements < ActiveRecord::Migration[5.2]
  def change
    create_table :inviting_managements do |t|
      t.references :company, null: false, foreign_key: true
      t.string :token ,null:false
      t.timestamps
    end
  end
end
