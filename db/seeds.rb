# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'date'
require 'faker'

User.destroy_all
puts "all users have been destroyed"
Event.destroy_all
puts "all events have been destroyed"
Attendance.destroy_all
puts "all attendances have been destroyed"

5.times do
	user = User.create(
											email:Faker::Internet.username + "@yopmail.com",
											password: "123456",
											description: Faker::Lorem.paragraph,
											f_name: Faker::Name.first_name,
											l_name: Faker::Name.last_name
										)
	puts "user #{ user.email } created"
	puts "#{user.errors.messages}"
end


6.times do 
	event = Event.create(
												start_date: DateTime.now + rand(1..6).days,
												duration: rand(1..10) * 5,
												title: Faker::Lorem.sentence,
												description: Faker::Lorem.paragraph,
												price: rand(1..1000),
												location: Faker::Address.city,
												admin_id: User.all.ids.sample		
											)
	puts "event #{ event.title } created"
	puts "#{event.errors.messages}"
end

12.times do
	attendance = Attendance.create(
																	stripe_customer_id: nil,
																	attendee_id: User.all.ids.sample,
																	event_id: Event.all.ids.sample			
																)
	puts "attendance created"
	puts "#{attendance.errors.messages}"
end

user = User.create(
										email: "n@mail.com",
										password: "123456",
										description: Faker::Lorem.paragraph,
										f_name: Faker::Name.first_name,
										l_name: Faker::Name.last_name
									)
puts "user #{ user.email } created"
puts "#{user.errors.messages}"