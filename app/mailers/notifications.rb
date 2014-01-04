class Notifications < ActionMailer::Base
  default from: "Lifted <no-reply@lifted.herokuapp.com>"

  def next_workout(user)
    @user = user
    mail to: @user.email, subject: "Today's Workout"
  end
end
