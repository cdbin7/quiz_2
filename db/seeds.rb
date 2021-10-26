# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Review.destroy_all
Idea.destroy_all

5.times do
  name = Faker::Name.name
  User.create(
    name: name,
    email: "#{name}@example.com",
    password: "123"
  )
end

users = User.all


50.times do
  created_at = Faker::Date.backward(days:365 * 5)

  i = Idea.create(
    title: Faker::Company.name,
    description: Faker::ChuckNorris.fact * 3,
    created_at: created_at,
    updated_at: created_at,
    user: users.sample
  )
  if i.valid?
    rand(3..5).times do
      Review.create(body:Faker::Hacker.say_something_smart, idea: i, user: users.sample)
    end
  end

end

ideas = Idea.all
reviews = Review.all
puts ideas.count
puts reviews.count
puts users.count