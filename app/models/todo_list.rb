class TodoList < ActiveRecord::Base
  has_many :todo_items

  validates :title, presence: true
  validates :description, presence: true
end
