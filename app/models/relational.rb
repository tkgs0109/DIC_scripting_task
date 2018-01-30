class Relational < ApplicationRecord
  belongs_to :parent, class_name: 'Task', foreign_key: :parent_id
  belongs_to :children, class_name: 'Task', foreign_key: :children_id
end
