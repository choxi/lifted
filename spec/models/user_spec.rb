require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }

  describe "#create_log!" do
    it "creates exercise logs for each exercise" do
      log = user.create_log!({
        exercises: [
          { name: "Squat", weight: 25 },
          { name: "Bench Press", weight: 50 }
        ]
      })

      log.exercises.map(&:name).should =~ ["Squat", "Bench Press"]
    end
  end

  describe "#next_workout" do
    it "returns a starting workout if the user has no previous workouts" do
      user.next_workout.exercises.map(&:name).should =~ Workout::A_DAY_EXERCISES 
    end

    it "returns alternating workout types" do
      log = FactoryGirl.create(:workout_a, user_id: user.id)

      user.next_workout.exercises.should_not include("Bench Press")
      user.next_workout.exercises.should include("Press")
    end
  end
end