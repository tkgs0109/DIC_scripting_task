class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.text :title
      t.text :content
      t.time :time_required
      t.boolean :descendant
      t.boolean :done
      t.integer :level
      t.datetime :limit

      t.timestamps
    end
  end
end
