class Notifications < ActionMailer::Base
  default from: "no-reply@lifted.herokuapp.com"

  def workout(user)
    mail to: user.email, subject: "Today's Workout"
  end
end
