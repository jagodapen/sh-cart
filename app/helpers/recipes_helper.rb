module RecipesHelper

  def preparation_time_hours(minutes)
    min = (minutes % 60).to_s + "min"
    hours = (minutes/60).floor.to_s + "h "
    minutes>59 ? hours + min : min
  end

  def recipe_product(id)
    Product.find(id)
  end
  
end
