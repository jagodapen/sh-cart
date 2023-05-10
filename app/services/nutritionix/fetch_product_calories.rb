# frozen_string_literal: true

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
      return unless product_info.present?

      ProductCalories.create(product_id: @product.id,
                             calories: product_info["nf_calories"],
                             unit: product_info["serving_unit"],
                             grams: product_info["serving_weight_grams"],
                             full_name: product_info["food_name"])
    end
  end
end
