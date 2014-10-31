namespace :cleanup do  
  desc "Delete list items if not completed in 7 days"
  task :delete_items do
    Todo.where("created_at <= ?", Time.now - 7.days).destroy_all
  end
end