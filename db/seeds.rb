# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.first
user.logs.destroy_all
squat     = Exercise.find_by_name("Squat")
deadlift  = Exercise.find_by_name("Deadlift")
bench     = Exercise.find_by_name("Bench Press")
press     = Exercise.find_by_name("Press")

20.times do |i|
  log = user.logs.create!(created_at: i.days.from_now)

  [squat, deadlift, bench, press].each do |exercise|
    log.exercise_logs.create!(weight: rand(5)*i, exercise: exercise)
  end
end
