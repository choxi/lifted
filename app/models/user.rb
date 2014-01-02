class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :logs

  def create_log!(log_params)
    log = logs.create!(logged_at: Time.now)

    log_params[:exercises].each do |exercise_params|
      exercise = Exercise.find_or_create_by!(name: exercise_params[:name])
      log.exercise_logs.create!(weight: exercise_params[:weight], exercise: exercise)
    end

    log
  end

  def next_workout
    if logs.count == 0
      Workout.starter_workout
    else
      logs.last.workout
    end
  end
end
