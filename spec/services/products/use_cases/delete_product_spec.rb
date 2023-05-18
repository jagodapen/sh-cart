# frozen_string_literal: true

require "rails_helper"

RSpec.describe Products::UseCases::DeleteProduct do
  describe "#call" do
    subject { described_class.new(product_id) }

    let!(:product) { create(:product_with_calories) }
    let(:product_id) { product.id }

    context "with valid params" do
      it "deletes the product" do
        expect { subject.call }.to change(Product, :count).by -1
      end

      it "deletes product calories" do
        expect { subject.call }.to change(ProductCalories, :count).by -1
      end
    end

    context "with invalid params" do
      let(:product_id) { nil }

      it "raises error" do
        expect { subject.call }.to raise_error(Base::Repository::RepositoryError)
      end
    end
  end
end
