class NotificationsPreview < MailView
  def next_workout
    Notifications.next_workout(User.first)
  end
end