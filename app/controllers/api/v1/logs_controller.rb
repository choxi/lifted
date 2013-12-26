class Api::V1::LogsController < ApiController
  respond_to :json

  # POST /api/v1/logs
  #   log => {
  #     exercises => [
  #       { name: "squat", weight: "25" },
  #       { name: "bench press", weight: "50" }
  #     ]
  #   }
  def create
    log = current_user.logs.create!(logged_at: Time.now)
    params[:log][:exercises].each do |exercise_params|
      exercise = Exercise.find_or_create_by_name!(exercise_params[:name])
      log.exercise_logs.create!(weight: exercise_params[:weight], exercise: exercise)
    end

    respond_with log, location: nil
  end

  # GET /api/v1/logs
  # 
  #  [
  #    {
  #      created_at: <timestamp>
  #      exercises: [
  #        {name: "Squat", weight: 25},
  #        {name: "Deadlift", weight: 15}
  #      ]
  #    }
  #  ]
  # 
  #  [
  #    {
  #      squat: [1, 2, 3, 4],     
  #      press: [3, 4, 7, 9]
  #    }
  #  ]
  def index
    respond_with current_user.logs.where("logged_at > ?", 1.month.ago)
  end
end