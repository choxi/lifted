FactoryGirl.define do
  factory :exercise do
    factory :squat do
      name "Squat"
    end

    factory :bench_press do
      name "Bench Press"
    end

    factory :deadlift do
      name "Deadlift"
    end

    factory :press do
      name "Press"
    end
  end
end