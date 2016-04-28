# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


10.times do
  User.create!(
  username: Faker::Internet.user_name,
  email: Faker::Internet.email,
  password: Faker::Internet.password
  )
end

20.times do
  RegisteredApplication.create(
    user_id: User.all.sample.id,
    title: Faker::Lorem.word,
    url: Faker::Internet.url
  )
end

100.times do
  Event.create(
  name: Faker::Superhero.power,
  registered_application_id: RegisteredApplication.all.sample.id
  )
end
