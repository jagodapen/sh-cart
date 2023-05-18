# frozen_string_literal: true

module Nutritionix
  class FetchProductCalories
    def initialize(product_name:, api_client:)
      @api_client = api_client
      @product_name = product_name
    end

    def call
      fetch_product_calories
    end

    private

    def fetch_product_calories
      @api_client.get_product_data(product_name: @product_name)
    end
  end
end
