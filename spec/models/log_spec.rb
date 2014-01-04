require 'spec_helper'

describe Log do
  let(:user) { FactoryGirl.create(:user) }

  describe "#next_log" do
    it "returns alternate workouts" do
      log = FactoryGirl.create(:workout_a, user: user)
      log.next_log.keys.should =~ ["Squat", "Press", "Deadlift"]

      log = FactoryGirl.create(:workout_b, user: user)
      log.next_log.keys.should =~ ["Squat", "Bench Press", "Deadlift"]
    end

    it "increments the weight by 5" do
      log = FactoryGirl.create(:workout_a, user: user)

      ["Squat", "Deadlift"].each do |exercise|
        log.next_log[exercise].should == log.summary[exercise] + 5
      end
    end
  end
end