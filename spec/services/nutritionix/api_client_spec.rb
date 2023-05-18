# frozen_string_literal: true

require "rails_helper"

RSpec.describe Nutritionix::ApiClient do
  describe "#get_product_data" do
    subject { described_class.new.get_product_data(product_name:) }

    let(:response) { { "foods" => [first_foods_result] } }
    let(:first_foods_result) do
      {
        food_name: "nutritionix food name",
        serving_unit: "oz",
        serving_weight_grams: 100,
        nf_calories: 50,
      }
    end
    let(:headers) do
      {
        "x-app-id": ENV.fetch("NUTRITIONIX_API_KEY", nil),
        "x-app-key": ENV.fetch("NUTRITIONIX_APP_ID", nil),
      }
    end
    let(:url) { "https://trackapi.nutritionix.com/v2/natural/nutrients" }
    let(:product_name) { "sample name" }

    before do
      stub_const("ENV", { NUTRITIONIX_API_KEY: "NUTRI_api_key", NUTRITIONIX_APP_ID: "NUTRI_app_id" })
      allow(HTTParty).to receive(:post).and_return(response)
    end

    it "sends request to nutritionix for product calories info" do
      subject
      expect(HTTParty)
        .to have_received(:post)
        .with(url, headers:, body: { query: product_name })
    end

    it "returns first product" do
      expect(subject).to eq(first_foods_result)
    end
  end
end
