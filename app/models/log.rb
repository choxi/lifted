class Log < ActiveRecord::Base
  has_many :exercise_logs
  has_many :exercises, through: :exercise_logs
  belongs_to :user

  def as_json(options)
    {
      created_at: created_at,
      exercises: exercise_logs
    }
  end
end