module ApplicationHelper
  def weight_to_plates(weight)
    (weight - 45).to_f / 2.0
  end
end
