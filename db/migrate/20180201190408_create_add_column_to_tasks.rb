class CreateAddColumnToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :descendant, :boolean
  end
end
