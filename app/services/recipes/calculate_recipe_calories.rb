class Recipes::CalculateRecipeCalories

  def initialize(recipe)
    @recipe = recipe
  end

  def call
    calculate_recipe_calories
  end

  private

  def calculate_recipe_calories
    @recipe.recipe_products.each do |rp|
      if rp.product_calories
        calories_of_one = rp.product_calories&.calories
        calculated_calories = calories_of_one * rp.quantity
        rp.update(calories: calculated_calories)
      end
    end
  end

end
