class ChangeColumnsToTask < ActiveRecord::Migration[5.1]
  def change
    change_column :tasks, :done, :boolean, null: false, default: false
  end
end
