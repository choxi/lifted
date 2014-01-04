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

  def last_log
    logs.order("created_at DESC").first
  end

  def last_weight_for(exercise_name)
    exercise = Exercise.find_by(name: exercise_name)
    last_log = ExerciseLog.joins(:log)
                          .where("logs.user_id = ? AND exercise_logs.exercise_id = ?", id, exercise.id)
                          .order("created_at DESC").first

    last_log.try(:weight) || 0
  end
end
