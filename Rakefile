# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Lifted::Application.load_tasks

task :import_historical_data => :environment do
  user = User.find_by_email!("roshan.choxi@gmail.com")
  
  squat     = Exercise.find_or_create_by(name: "Squat")
  deadlift  = Exercise.find_or_create_by(name: "Deadlift")
  bench     = Exercise.find_or_create_by(name: "Bench Press")
  press     = Exercise.find_or_create_by(name: "Press")

  log = user.logs.create!(logged_at: Date.parse("December 23, 2013"))
  log.exercise_logs.create!(weight: 165, exercise_id: deadlift.id)
  log.exercise_logs.create!(weight: 185, exercise_id: squat.id)
  log.exercise_logs.create!(weight: 135, exercise_id: bench.id)

  log = user.logs.create!(logged_at: Date.parse("December 20, 2013"))
  log.exercise_logs.create!(weight: 135,  exercise_id: deadlift.id)
  log.exercise_logs.create!(weight: 175,  exercise_id: squat.id)
  log.exercise_logs.create!(weight: 95,   exercise_id: press.id)

  log = user.logs.create!(logged_at: Date.parse("December 18, 2013"))
  log.exercise_logs.create!(weight: 125, exercise_id: deadlift.id)
  log.exercise_logs.create!(weight: 165, exercise_id: squat.id)
  log.exercise_logs.create!(weight: 115, exercise_id: bench.id)

  log = user.logs.create!(logged_at: Date.parse("December 13, 2013"))
  log.exercise_logs.create!(weight: 115,  exercise_id: deadlift.id)
  log.exercise_logs.create!(weight: 155,  exercise_id: squat.id)
  log.exercise_logs.create!(weight: 85,   exercise_id: press.id)
end