# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Lifted::Application.load_tasks

task :send_workout_notification => :environment do
  today = Date.today

  if today.monday? || today.wednesday? || today.friday? || ENV["FORCE"]
    User.all.each do |user|
      Notifications.next_workout(user).deliver
    end
  end
end