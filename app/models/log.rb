class Log < ActiveRecord::Base
  has_many :exercise_logs
  has_many :exercises, through: :exercise_logs
  belongs_to :user
end