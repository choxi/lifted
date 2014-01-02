class Workout
  A_DAY_EXERCISES = ["Squat", "Bench Press", "Deadlift"]
  B_DAY_EXERCISES = ["Squat", "Press", "Deadlift"]

  attr_reader :exercises

  def self.starter_workout
    Workout.new Exercise.where("name in (?)", A_DAY_EXERCISES)
  end

  def initialize(exercises)
    @exercises = exercises
  end
end