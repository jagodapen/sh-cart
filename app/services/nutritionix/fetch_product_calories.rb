module Nutritionix

  class FetchProductCalories

    def initialize(product, api_client)
      @api_client = api_client
      @product = product
    end

    def call
      fetch_product_calories
    end

    private

    def fetch_product_calories
      product_info = @api_client.get_product_data(@product.name)
      if product_info.present?
        ProductCalories.create(product_id: @product.id,
                            calories: product_info.dig("nf_calories"),
                            unit: product_info.dig("serving_unit"),
                            grams: product_info.dig("serving_weight_grams"),
                            full_name: product_info.dig("food_name"))
      end
    end

  end

end
