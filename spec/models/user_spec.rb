require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }

  describe "after_create hooks" do
    it "generates an authentication token" do
      user.authentication_token.should_not be_blank
    end
  end

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

    it "skips the exercise log if the weight is 0" do
      log = user.create_log!({
        exercises: [
          { name: "Squat", weight: 25 },
          { name: "Bench Press", weight: 0 }
        ]
      })

      log.exercises.map(&:name).should =~ ["Squat"]
    end
  end

  describe "#last_weight_for" do
    it "returns the most recent weight done for that exercise" do
      log_a = FactoryGirl.create(:workout_a, user: user)
      log_b = FactoryGirl.create(:workout_b, user: user)

      user.last_weight_for("Squat").should        == log_b.summary["Squat"]
      user.last_weight_for("Bench Press").should  == log_a.summary["Bench Press"]
    end
  end
end