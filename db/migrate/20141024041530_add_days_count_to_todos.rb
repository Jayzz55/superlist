class AddDaysCountToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :days_count, :integer
  end
end
