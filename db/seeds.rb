require 'faker'

5.times do 
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password:Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save!
end

users = User.all

5.times do 
  Category.create!(
    user: users.sample,
    body: Faker::Lorem.sentence
  )
end
categories = Category.all

10.times do
  Todo.create!(
    user: users.sample,
    category: categories.sample,
    body: Faker::Lorem.sentence,
    days_count: Time.now - 7.days
  )
end


User.first.update_attributes!(
  name: 'admin',
  email: 'admin@example.com',
  password: 'helloworld'
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Category.count} categories created"
puts "#{Todo.count} todos created"