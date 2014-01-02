FactoryGirl.define do
  factory :log do
    logged_at Time.now

    factory :workout_a do
      after(:create) do |log|
        [:squat, :bench_press, :deadlift].each do |name|
          exercise = FactoryGirl.create(name)
          log.exercise_logs.create!(exercise: exercise, weight: rand(25))
        end
      end
    end
  end
end