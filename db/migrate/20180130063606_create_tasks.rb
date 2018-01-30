class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.text :title
      t.text :content
      t.time :time_required
      t.integer :level
      t.datetime :limit
      t.integer :parent_id
      t.integer :children_id

      t.index :parent_id
      t.index :children_id
      t.index [:parent_id, :children_id], unique: true

      t.timestamps
    end
  end
end
