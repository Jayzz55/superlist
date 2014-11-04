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

# Create me
 member = User.new(
   name:     'Jayzz55',
   email:    'jayzzwijono@yahoo.com',
   password: 'helloworld',
 )
 member.skip_confirmation!
 member.save!

users = User.all


20.times do
  Todo.create!(
    user: users.sample,
    body: Faker::Lorem.sentence,
  )
end


puts "Seed finished"
puts "#{User.count} users created"
puts "#{Todo.count} todos created"