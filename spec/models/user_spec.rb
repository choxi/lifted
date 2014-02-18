require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }

  describe "after_create hooks" do
    it "generates an authentication token" do
      user.authentication_token.should_not be_blank
    end
  end

  describe "#next_log" do
    it "returns alternate workouts" do
      log = FactoryGirl.create(:workout_a, user: user)
      user.next_log.keys.should =~ ["Squat", "Press", "Deadlift"]

      sleep 1 # otherwise the created_at timestamps are too close

      log = FactoryGirl.create(:workout_b, user: user)
      user.next_log.keys.should =~ ["Squat", "Bench Press", "Deadlift"]
    end

    it "returns the alternate workout even if the previous one wasn't completed" do
      log = FactoryGirl.create(:workout_a, user: user)
      deadlift = Exercise.find_by_name("Deadlift")
      log.exercise_logs.where(exercise_id: deadlift.id).first.destroy!
      log.reload # undo memoization of .next_log

      user.next_log.keys.should =~ ["Squat", "Press", "Deadlift"]
    end

    it "increments the weight by 5" do
      log = FactoryGirl.create(:workout_a, user: user)

      ["Squat", "Deadlift"].each do |exercise|
        user.next_log[exercise].should == log.summary[exercise] + 5
      end
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