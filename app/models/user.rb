class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :logs
  before_create lambda {|user| user.authentication_token = SecureRandom.hex }

  def create_log!(log_params)
    log = logs.create!(logged_at: Time.now)

    log_params[:exercises].each do |exercise_params|
      next if exercise_params[:weight] == 0
    
      exercise = Exercise.find_or_create_by!(name: exercise_params[:name])
      log.exercise_logs.create!(weight: exercise_params[:weight], exercise: exercise)
    end

    log
  end

  def next_log
    @next_log = {}
    last_press        = last_exercise_log_for("Press")
    last_bench_press  = last_exercise_log_for("Bench Press")

    if last_press.try(:created_at).to_i > last_bench_press.try(:created_at).to_i
      exercises = Workout::A_DAY_EXERCISES
    else
      exercises = Workout::B_DAY_EXERCISES
    end

    exercises.each do |exercise_name|
      @next_log[exercise_name] = last_weight_for(exercise_name) + 5
    end

    @next_log
  end

  def last_log
    logs.order("created_at DESC").first
  end

  def last_exercise_log_for(exercise_name)
    exercise = Exercise.find_by(name: exercise_name)
    last_log = ExerciseLog.joins(:log)
                          .where("logs.user_id = ? AND exercise_logs.exercise_id = ?", id, exercise.id)
                          .order("created_at DESC").first
  end

  def last_weight_for(exercise_name)
    last_exercise_log_for(exercise_name).try(:weight) || 0
  end
end
