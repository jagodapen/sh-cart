require 'httparty'

module Nutritionix

# ---------------------------can't get calories
# class ApiClient
#   include HTTParty
#   format :json
#   base_uri "https://api.nutritionix.com"
#
#   def initialize()
#   end
#
#   def get(product)
#     api_key = Rails.application.credentials.dig(:nutritionix, :api_key)
#     app_id = Rails.application.credentials.dig(:nutritionix, :app_id)
#     params = {
#               headers: { "Content-Type":"application/json" },
#               body: [{ appId: app_id,
#                       appKey: api_key,
#                       fields: ["item_name", "brand_name", "nf_calories", "nf_serving_weight_grams", "nf_serving_size_qty"]
#                     }].to_json
#               }
#     response = self.class.get("/v1_1/search/#{product.parameterize.underscore}?", params).parsed_response
#     @product = response["hits"][0]
#   end
#
#   def calories
#     @product["fields"]["nf_calories"]
#   end
#
#   def grams
#     @product["fields"]["nf_serving_weight_grams"]
#   end
#
#   def quantity
#     @product["fields"]["nf_serving_size_qty"]
#   end
#
# end

# ---------------------------works, but not sure if this is correct, pretty way
class ApiClient
  include HTTParty
  format :json
  base_uri "https://api.nutritionix.com"

  def initialize
    @api_key = Rails.application.credentials.dig(:nutritionix, :api_key)
    @app_id = Rails.application.credentials.dig(:nutritionix, :app_id)
  end

  def get_product_data(product)
    response = HTTParty.get("https://api.nutritionix.com/v1_1/search/#{product.parameterize.underscore}?results=0:2&fields=item_name,brand_name,item_id,nf_calories,nf_serving_weight_grams&appId=#{@app_id}&appKey=#{@api_key}")
    @product = response.dig("hits")&.first.dig("fields")
  end

  def calories
    self.dig("nf_calories")
  end

  def grams
    @product.dig("fields", "nf_serving_weight_grams")
  end

  def unit
    @product.dig("fields", "nf_serving_size_unit")
  end

  def full_name
    @product.dig("fields", "item_name")
  end
end


# ------------------------not httparty - don't know how to get calories from response.body
  # class ApiClient
  #   require 'net/http'
  #   require 'uri'
  #   require 'json'
  #
  #   def initialize(product)
  #     api_key = Rails.application.credentials.dig(:nutritionix, :api_key)
  #     app_id = Rails.application.credentials.dig(:nutritionix, :app_id)
  #
  #     uri = URI.parse("https://api.nutritionix.com/v1_1/search")
  #     request = Net::HTTP::Post.new(uri)
  #     request.content_type = "application/json"
  #     request.body = JSON.dump({
  #       "appId" => "#{app_id}",
  #       "appKey" => "#{api_key}",
  #       "query" => product
  #     })
  #
  #     req_options = {
  #       use_ssl: uri.scheme == "https",
  #     }
  #
  #     response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  #       http.request(request)
  #     end
  #
  #     @products = response.body
  #   end
  #
  # end

end
