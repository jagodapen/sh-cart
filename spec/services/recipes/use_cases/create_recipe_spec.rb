# frozen_string_literal: true

require "rails_helper"
# rubocop:disable RSpec/MultipleMemoizedHelpers
RSpec.describe Recipes::UseCases::CreateRecipe do
  subject { described_class.new(recipe, params) }

  let(:products) { create_list(:product, 2) }
  let(:recipe_products_params) do
    [
      { product_id: products.first.id, grams: 100, quantity: 1, unit: "item" },
      { product_id: products.second.id, grams: 200, quantity: 2, unit: "item" },
    ]
  end
  let(:calculator) { double("Recipes::UseCases::CalculateRecipeProductsCalories") }
  let(:products_calories) { { products.first.id => 100, products.second.id => 200 } }

  before do
    allow(Recipes::UseCases::CalculateRecipeProductsCalories).to receive(:new).and_return(calculator)
    allow(calculator).to receive(:call).and_return(products_calories)
  end

  context "with valid params" do
    let(:recipe) { build(:recipe) }
    let(:params) do
      {
        name: recipe.name,
        description: recipe.description,
        preparation_time: recipe.preparation_time,
        recipe_products_attributes: {
          "0": { product_id: products.first.id, grams: 100, quantity: 1, unit: "item" },
          "1": { product_id: products.second.id, grams: 200, quantity: 2, unit: "item" },
        },
      }
    end

    it "creates recipe" do
      expect { subject.call }.to change(Recipe, :count).by(1).and change(RecipeProduct, :count).by(2)

      saved_recipe ||= Recipe.last
      expect(saved_recipe.calories).to eq 300
      expect(saved_recipe.products).to eq([products.first, products.second])
    end
  end

  context "with invalid recipe params" do
    let(:recipe) { build(:recipe, name: nil) }
    let(:params) do
      {
        name: recipe.name,
        description: recipe.description,
        preparation_time: recipe.preparation_time,
        recipe_products_attributes: {
          "0": { product_id: products.first.id, grams: 100, quantity: 1, unit: "item" },
          "1": { product_id: products.second.id, grams: 200, quantity: 2, unit: "item" },
        },
      }
    end

    it "adds errors to recipe" do
      expect { subject.call }.not_to change(Recipe, :count)
      expect(recipe.errors).not_to be_nil
    end
  end

  context "without products" do
    let(:recipe) { build(:recipe) }
    let(:params) do
      {
        name: recipe.name,
        description: recipe.description,
        preparation_time: recipe.preparation_time,
        recipe_products_attributes: {},
      }
    end

    it "adds errors to recipe" do
      expect { subject.call }.not_to change(Recipe, :count)
      expect(recipe.errors).not_to be_nil
    end
  end
  # rubocop:enable RSpec/MultipleMemoizedHelpers
end
