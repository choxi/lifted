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

  def workout
    exercise_attributes = exercise_logs.map {|e| {name: e.exercise.name, weight: e.weight}}
    @workout ||= Workout.new(exercise_attributes)
  end

  def next_workout
    exercise_names = exercises.map { |hash| hash[:name] }

    if exercise_names.include?
  end
end