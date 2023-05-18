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

    def get_product_data(product_name:)
      response = send_request(product_name)
      get_first_result(response)
    end

    private

    def send_request(product_name)
      HTTParty.post(
        "https://trackapi.nutritionix.com/v2/natural/nutrients",
        headers:,
        body: { query: product_name },
      )
    end

    def headers
      {
        "x-app-id": @app_id,
        "x-app-key": @api_key,
      }
    end

    def get_first_result(response)
      response["foods"]&.first
    end
  end
end
