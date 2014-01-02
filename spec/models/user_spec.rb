require 'spec_helper'

describe User do
  describe "#next_workout" do
    it "returns a starting workout if the user has no previous workouts" do
      user = FactoryGirl.create(:user)
      user.next_workout.exercises.map(&:name).should =~ Workout::A_DAY_EXERCISES 
    end

    it "returns alternating workout types" do
      user = FactoryGirl.create(:user)

    end
  end
end