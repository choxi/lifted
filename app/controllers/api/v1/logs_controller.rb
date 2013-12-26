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
    log = current_user.logs.create!
    params[:log][:exercises].each do |exercise|
      exercise = Exercise.find_or_create_by_name!(exercise[:name])
      log.exercise_logs.create!(weight: exercise[:weight], exercise: exercise)
    end

    respond_with log, location: nil
  end
end