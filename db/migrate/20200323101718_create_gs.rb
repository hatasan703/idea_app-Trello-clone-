class CreateGs < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.references :group,index: true
      t.references :user,index:true
      t.boolean :admin
      t.boolean :activate

      t.timestamps
    end
  end
end
