module RecipesHelper
  def preparation_time_hours(minutes)
    min = "#{minutes % 60}min"
    hours = "#{(minutes / 60).floor}h "
    minutes > 59 ? hours + min : min
  end
end
