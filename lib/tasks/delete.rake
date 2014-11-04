namespace :cleanup do  
  desc "Delete todo items if not completed in 7 days"
  task :delete_old_items do
    Todo.delete_old_items
  end
end