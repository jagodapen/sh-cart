module Recipes
  class CalculateRecipeProductsCalories
    def initialize(recipe)
      @recipe = recipe
    end

    def call
      calculate_recipe_products_calories
    end

    private

    def calculate_recipe_products_calories
      @recipe.recipe_products.each do |rp|
        next unless rp.product_calories
        calories_of_one = rp.product_calories&.calories
        calculated_calories = calories_of_one * rp.quantity
        rp.update(calories: calculated_calories)
      end
    end
  end
end
