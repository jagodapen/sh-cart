class CaloriesCalculator

  def self.calculate_calories(recipe)

    @recipe_products = RecipeProduct.where(recipe_id: recipe.id)
    recipe.calories = 0

    recipe.products.each do |product|
      product_calories = product.calories * @recipe_products.find(product_id: product.id).quantity
      recipe.calories =+ product_calories
    end
  end

end
