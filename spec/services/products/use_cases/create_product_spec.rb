# frozen_string_literal: true

require "rails_helper"

RSpec.describe Products::UseCases::CreateProduct do
  describe "#call" do
    subject { described_class.new(product) }

    let(:product) { Product.new(name: "Product name", product_type: Product::PRODUCT_TYPES.sample) }
    let(:nutritionix_service_object) { double("nutritionix") }
    let(:validation_object) { double("validation") }
    let(:nutritionix_api_client) { double("nutritionix_api_client") }

    before do
      allow(Nutritionix::ApiClient).to receive(:new).and_return(nutritionix_api_client)
      allow(Nutritionix::FetchProductCalories)
        .to receive(:new)
        .with(product, nutritionix_api_client)
        .and_return(nutritionix_service_object)
      allow(nutritionix_service_object).to receive(:call)
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
        expect(Nutritionix::FetchProductCalories).to have_received(:new).with(product, nutritionix_api_client)
        expect(nutritionix_service_object).to have_received(:call)
      end
    end

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
    end
  end
end
