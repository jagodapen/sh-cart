# frozen_string_literal: true

require "httparty"

module Nutritionix
  class ApiClient
    include HTTParty
    format :json

    def initialize
      @api_key = ENV["NUTRITIONIX_API_KEY"]
      @app_id = ENV["NUTRITIONIX_APP_ID"]
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
