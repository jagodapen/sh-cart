module RecipesHelper

  def preparation_time_hours(minutes)
    min = (minutes % 60).to_s + "min"
    hours = (minutes/60).floor().to_s + "h "
    @preparation_time_hours = minutes>59 ? hours + min : min
  end

  def recipe_product(id)
    @recipe_product = Product.find(id)
  end

  def all_products
    @all_products = Product.all
  end

  def grouped_products
    @grouped_products = Product.all.group_by(&:product_type)
  end

end
