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
    log = current_user.create_log!(params[:log])
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
    respond_with current_user.logs.where("logged_at > ?", 1.month.ago).order("logged_at ASC")
  end
end