class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :logs

  def next_workout
    if logs.count == 0
      Workout.starter_workout
    else
      last_workout = Workout.new(logs.last)
      next_workout = last_workout.next_workout
    end
  end
end
