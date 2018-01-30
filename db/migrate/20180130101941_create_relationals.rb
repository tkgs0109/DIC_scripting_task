class CreateRelationals < ActiveRecord::Migration[5.1]
  def change
    create_table :relationals do |t|
      t.integer :parent_id, null: false
      t.integer :children_id, null: false
      t.index :parent_id
      t.index :children_id, unique: true
      t.index [:parent_id, :children_id], unique: true

      t.timestamps
    end
  end
end
