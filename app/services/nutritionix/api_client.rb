require 'httparty'

module Nutritionix

  class ApiClient
    include HTTParty
    format :json

    def initialize
      @api_key = Rails.application.credentials.dig(:nutritionix, :api_key)
      @app_id = Rails.application.credentials.dig(:nutritionix, :app_id)
    end

    def get_product_data(product)
      headers = {
        "x-app-id": @app_id,
        "x-app-key": @api_key
      }
      response = HTTParty.post("https://trackapi.nutritionix.com/v2/natural/nutrients", headers: headers, body: { "query": product})
      @product = response.dig("foods")&.first
    end

  end

end
