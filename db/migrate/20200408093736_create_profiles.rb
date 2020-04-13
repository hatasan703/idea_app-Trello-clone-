class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.references :user  ,null: false, foreign_key: true
      t.string :image
      t.string :name ,null: false
      t.integer :sex ,null:false
      t.string :self_introduction,null:false
      t.timestamps
    end
  end
end
