# frozen_string_literal: true

require "rails_helper"

# rubocop:disable RSpec/ExampleLength
RSpec.describe FetchProductCalories do
  describe "#fetch_calories" do
    it "sends request to NutritionixAPI for calories info and saves data" do
      product_calories_data = { "food_name" => "brie",
                                "serving_qty" => 1,
                                "serving_unit" => "oz",
                                "serving_weight_grams" => 28.35,
                                "nf_calories" => 94.69 }
      allow_any_instance_of(Nutritionix::ApiClient).to receive(:get_product_data).and_return(product_calories_data)
      product = create(:product)
      expect(product.product_calories[:calories]).to eq(product_calories_data["nf_calories"])
      expect(product.product_calories[:unit]).to eq(product_calories_data["serving_unit"])
      expect(product.product_calories[:grams]).to eq(product_calories_data["serving_weight_grams"].to_i)
      expect(product.product_calories[:full_name]).to eq(product_calories_data["food_name"])
    end
  end
end
# rubocop:enable RSpec/ExampleLength
