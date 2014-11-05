class Todo < ActiveRecord::Base
  belongs_to :user
  
  validates :body, length: { minimum: 5 }, presence: true

  default_scope { order('created_at ASC') }

  def days_left
    ((self.created_at + 8.days - Time.now).to_i)/60/60/24
  end

  def self.delete_old_items
    Todo.where("created_at <= ?", Time.now - 7.days).destroy_all
  end

end
