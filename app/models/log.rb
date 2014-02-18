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

  def summary
    summary = {}

    exercise_logs.each {|log| summary[log.exercise.name] = log.weight }

    summary
  end
end