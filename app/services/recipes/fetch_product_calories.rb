# after recipe create or update fetch products calories data from Nutritionix
class FetchProductCalories
  def self.after_save(recipe)
    recipe.products.each do |product|
      if !!(ProductCalories.find(product))
        nutritionix_product = Nutritionix::ApiClient.new("#{product.name}")
        ProductCalories.create(product_id: product.id,
                            calories: nutritionix_product.calories,
                            unit: nutritionix_product.unit,
                            quantity: nutritionix_product.grams)
      end
    end
  end
end
