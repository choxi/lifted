class Log < ActiveRecord::Base
  has_many :exercise_logs
  has_many :exercises, through: :exercise_logs
  belongs_to :user

  def as_json(options)
    {
      created_at: logged_at,
      exercises: exercise_logs
    }
  end

  def next_log
    @next_log = {}

    exercise_logs.each do |exercise_log|
      exercise = exercise_log.exercise

      if exercise.name == "Bench Press"
        @next_log["Press"] = user.last_weight_for("Press") + 5
      elsif exercise.name == "Press"
        @next_log["Bench Press"] = user.last_weight_for("Bench Press") + 5 
      else
        @next_log[exercise.name] = user.last_weight_for(exercise.name) + 5
      end
    end

    @next_log
  end

  def summary
    summary = {}

    exercise_logs.each {|log| summary[log.exercise.name] = log.weight }

    summary
  end
end