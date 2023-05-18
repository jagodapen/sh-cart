# frozen_string_literal: true

require "rails_helper"

RSpec.describe Products::UseCases::CreateProduct do
  describe "#call" do
    subject { described_class.new(product) }

    let(:product) { Product.new(name: "Product name", product_type: Product::PRODUCT_TYPES.sample) }
    let(:nutritionix_service_object) { double("nutritionix") }
    let(:nutritionix_api_client) { double("nutritionix_api_client") }
    let(:product_info) do
      {
        food_name: "sample name",
        serving_unit: "oz",
        serving_weight_grams: 100,
        nf_calories: 50,
      }
    end

    before do
      allow(Nutritionix::ApiClient).to receive(:new).and_return(nutritionix_api_client)
      allow(Nutritionix::FetchProductCalories)
        .to receive(:new)
        .with(product_name: product.name, api_client: nutritionix_api_client)
        .and_return(nutritionix_service_object)
      allow(nutritionix_service_object).to receive(:call).and_return(product_info)
    end

    context "with valid params" do
      it "creates the product" do
        expect { subject.call }.to change(Product, :count).by 1
      end

      it "does not add errors to product" do
        subject.call
        expect(product.errors).to be_empty
      end

      it "fetches calories" do
        subject.call
        expect(Nutritionix::FetchProductCalories)
          .to have_received(:new)
          .with(product_name: product.name, api_client: nutritionix_api_client)
        expect(nutritionix_service_object).to have_received(:call)
      end

      # rubocop:disable RSpec/ExampleLength
      it "creates product calories with correct data" do
        expect { subject.call }.to change(ProductCalories, :count).by 1

        expected_attributes = {
          product_id: product.id,
          calories: product_info["nf_calories"],
          unit: product_info["serving_unit"],
          grams: product_info["serving_weight_grams"],
          full_name: product_info["food_name"],
        }
        product_calories_attributes = ProductCalories.last.attributes.symbolize_keys
        expect(product_calories_attributes).to include(expected_attributes)
      end
    end
    # rubocop:enable RSpec/ExampleLength

    context "with invalid params" do
      let(:product) { Product.new(name: "111", product_type: Product::PRODUCT_TYPES.sample) }

      it "does not create the product" do
        expect { subject.call }.not_to change(Product, :count)
      end

      it "adds error to product" do
        subject.call
        expect(product.errors).to be_present
      end

      it "does not fetch calories" do
        subject.call
        expect(Nutritionix::FetchProductCalories).not_to have_received(:new)
      end

      it "does not create the product calories" do
        expect { subject.call }.not_to change(ProductCalories, :count)
      end
    end
  end
end
