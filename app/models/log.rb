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
    exercise_names = exercises.map { |hash| hash[:name] }

    @next_log ||= exercise_logs.map do |exercise_log|
      exercise      = exercise_log.exercise
      previous_log  = user.logs.where("created_at < ?", created_at).first

      if exercise.name == "Bench Press"
        { "Press" => user.last_weight_for("Press") + 5 }
      elsif exercise.name == "Press"
        { "Bench Press" => user.last_weight_for("Bench Press") + 5 }
      else
        { exercise.name => user.last_weight_for(exercise.name) + 5 }
      end
    end
  end

  def summary
    summary = {}

    exercise_logs.each {|log| summary[log.exercise.name] = log.weight }

    summary
  end
end