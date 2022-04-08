class CaloriesCalculator

  def calculate_calories(recipe)

    @recipe_products = RecipeProduct.where(recipe_id: recipe.id)
    recipe_calories = 0

    recipe.products.each do |product|
      product_calories = product.calories * @recipe_products.find(product_id: product.id).quantity
      recipe_calories =+ product_calories
    end

    return recipe_calories
  end

end
