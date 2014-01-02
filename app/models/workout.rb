class Workout
  A_DAY_EXERCISES = ["Squat", "Bench Press", "Deadlift"]
  B_DAY_EXERCISES = ["Squat", "Press", "Deadlift"]

  attr_reader :exercises

  def self.starter_workout
    exercises = Exercise.where("name in (?)", A_DAY_EXERCISES)
    Workout.new exercises.map {|e| {name: e.name, weight: 25 } }
  end

  def initialize(exercises)
    @exercises = exercises
  end
end