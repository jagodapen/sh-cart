# frozen_string_literal: true

require "httparty"

module Nutritionix
  class ApiClient
    include HTTParty
    format :json

    def initialize
      @api_key = ENV.fetch("NUTRITIONIX_API_KEY", nil)
      @app_id = ENV.fetch("NUTRITIONIX_APP_ID", nil)
    end

    def get_product_data(product)
      headers = {
        "x-app-id": @app_id,
        "x-app-key": @api_key,
      }
      response = HTTParty.post("https://trackapi.nutritionix.com/v2/natural/nutrients",
                               headers:,
                               body: { query: product })
      @product = response["foods"]&.first
    end
  end
end
