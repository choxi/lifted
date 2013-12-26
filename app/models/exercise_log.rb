class ExerciseLog < ActiveRecord::Base
  belongs_to :exercise
  belongs_to :log

  def as_json(options={})
    {
      name: exercise.name,
      weight: weight
    }
  end

  def weight
    super || 10
  end
end