class Todo < ActiveRecord::Base
  belongs_to :user

  def days_left
    ((self.created_at + 8.days - Time.now).to_i)/60/60/24
  end

end
