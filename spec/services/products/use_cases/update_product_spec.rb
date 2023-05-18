# frozen_string_literal: true

require "rails_helper"

RSpec.describe Products::UseCases::UpdateProduct do
  describe "#call" do
    subject { described_class.new(product, params) }

    let(:product) { create(:product, product_type: product_types.second) }
    let(:product_types) { Product::PRODUCT_TYPES }

    context "with valid params" do
      let(:params) { { name: product.name, product_type: product_types.third } }

      it "updates the product" do
        expect { subject.call }.to change(product, :product_type).from(product_types.second).to(product_types.third)
      end

      it "does not add errors to product" do
        subject.call
        expect(product.errors).to be_empty
      end
    end

    context "with invalid params" do
      let(:params) { { name: "New name", product_type: product_types.third } }

      it "does not update the product" do
        expect { subject.call }.not_to change(product, :product_type)
      end

      it "adds error to product" do
        subject.call
        expect(product.errors).to be_present
      end
    end
  end
end
