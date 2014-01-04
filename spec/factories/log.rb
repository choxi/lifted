FactoryGirl.define do
  factory :log do
    logged_at Time.now

    factory :workout_a do
      after(:create) do |log|
        ["Squat", "Bench Press", "Deadlift"].each do |name|
          exercise = Exercise.find_or_create_by(name: name)
          log.exercise_logs.create!(exercise: exercise, weight: rand(25))
        end
      end
    end

    factory :workout_b do
      after(:create) do |log|
        ["Squat", "Press", "Deadlift"].each do |name|
          exercise = Exercise.find_by(name: name)
          log.exercise_logs.create!(exercise: exercise, weight: rand(25))
        end
      end
    end
  end
end