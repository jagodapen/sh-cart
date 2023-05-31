# frozen_string_literal: true

require "rails_helper"
# rubocop:disable RSpec/ExampleLength
RSpec.describe Recipes::UseCases::CalculateRecipeProductsCalories do
  subject { described_class.new(recipe_products_params) }

  let(:recipe_products_params) do
    [
      {
        product_id: product1.id,
        grams: 50,
      },
      {
        product_id: product2.id,
        grams: 200,
      },
    ]
  end

  let(:product1) { create(:product, product_calories: product_calories1) }
  let(:product2) { create(:product, product_calories: product_calories2) }
  let(:product_calories1) { create(:product_calories, calories: 100, grams: 100) }
  let(:product_calories2) { create(:product_calories, calories: 200, grams: 100) }
  let(:expected_response) { { product1.id => 50.0, product2.id => 400.0 } }

  it "calculates recipe products calories" do
    expect(subject.call).to eq(expected_response)
  end

  context "with product with no grams passed" do
    let(:recipe_products_params) do
      [
        {
          product_id: product1.id,
          grams: 50,
        },
        {
          product_id: product2.id,
        },
      ]
    end
    let(:expected_response) { { product1.id => 50.0 } }

    it "skips calories calculation" do
      expect(subject.call).to eq(expected_response)
    end
  end

  context "with missing product id in params" do
    let(:recipe_products_params) { [{ grams: 50 }] }
    let(:expected_response) { { } }

    it "returns empry hash" do
      expect(subject.call).to eq(expected_response)
    end
  end

  context "with empty params" do
    let(:recipe_products_params) { [] }
    let(:expected_response) { {} }

    it "returns empry hash" do
      expect(subject.call).to eq(expected_response)
    end
  end
end
# rubocop:enable RSpec/ExampleLength
