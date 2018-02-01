class Task < ApplicationRecord
  belongs_to :user

  has_many :parent_relationals, class_name: 'Relational', foreign_key: :parent_id
  has_many :children_relationals, class_name: 'Relational', foreign_key: :children_id, dependent: :destroy
  has_many :parent_task, through: :children_relationals, source: :parent
  has_many :children_tasks, through: :parent_relationals, source: :children, dependent: :destroy

  def has_children?(task)
    task.children_tasks.any?
  end
end
