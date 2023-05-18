# frozen_string_literal: true

require "rails_helper"

RSpec.describe Nutritionix::FetchProductCalories do
  describe "#call" do
    subject { described_class.new(product_name: product.name, api_client:) }

    let(:product) { build(:product) }
    let(:api_client) { double("Nutritionix::ApiClient", get_product_data: product_info) }
    let(:product_info) { { sample_key: "sample name" } }

    it "sends request to api client for product calories info" do
      subject.call
      expect(api_client).to have_received(:get_product_data).with(product_name: product.name)
    end

    it "returns product_info" do
      expect(subject.call).to eq(product_info)
    end
  end
end
