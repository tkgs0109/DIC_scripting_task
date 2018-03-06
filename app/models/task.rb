class Task < ApplicationRecord
  default_scope -> { order("tasks.id") }

  belongs_to :user

  has_many :parent_relationals, class_name: 'Relational', foreign_key: :parent_id
  has_many :children_relationals, class_name: 'Relational', foreign_key: :children_id, dependent: :destroy
  has_many :parent_task, through: :children_relationals, source: :parent
  has_many :children_tasks, through: :parent_relationals, source: :children, dependent: :destroy

  validates :title, presence: true

  def self.descendant_tasks(uid)
    descendant_ids = Array.new
    mytasks = Task.where(user_id: uid)
    mytasks.each do |task|
      unless task.children_tasks.any?
        descendant_ids << task.id
      end
    end
    return descendant_ids
  end

  # 自分も含めた親子関係を配列で返すメソッド
  def clans_to_me
    clan = Array.new
    task = self
    clan.unshift(task.id)
    while true
      if task.parent_task.first.nil?
        break
      else
        clan.unshift(task.parent_task.ids.first)
        task = Task.find(clan.first)
      end
    end
    return clan
  end

  # 自分の親までの親子関係を配列で返すメソッド
  def clans
    clan = Array.new
    task = self
    while true
      if task.parent_task.first.nil?
        break
      else
        clan.unshift(task.parent_task.ids.first)
        task = Task.find(clan.first)
      end
    end
    return clan
  end
end
