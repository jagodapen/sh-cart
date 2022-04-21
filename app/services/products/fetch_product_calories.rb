class Products::FetchProductCalories

  def initialize(product)
    @product = product
  end

  def call
    fetch_product_calories
  end

  private

  def fetch_product_calories
    nutritionix_product = Nutritionix::ApiClient.new
    product_info = nutritionix_product.get_product_data(@product.name)
    if product_info.present?
      ProductCalories.create(product_id: @product.id,
                          calories: product_info.dig("nf_calories"),
                          unit: product_info.dig("serving_unit"),
                          grams: product_info.dig("serving_weight_grams"),
                          full_name: product_info.dig("food_name"))
    end
  end

end
