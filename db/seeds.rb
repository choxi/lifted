# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.first
user.logs.destroy_all
exercise = Exercise.find_by_name("Squat")

20.times do |i|
  log = user.logs.create!
  log.exercise_logs.create!(weight: rand(20), exercise: exercise, created_at: i.days.from_now)
end
