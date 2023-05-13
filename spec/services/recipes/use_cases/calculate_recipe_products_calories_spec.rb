# frozen_string_literal: true

require "rails_helper"
# rubocop:disable RSpec/ExampleLength
RSpec.describe Recipes::UseCases::CalculateRecipeProductsCalories do
  it "calculates recipe products calories" do
    product_calories1 = double(:product_calories, calories: 100)
    product_calories2 = double(:product_calories, calories: 200)
    product1 = double(:product, id: 1234, product_calories: product_calories1)
    product2 = double(:product, id: 5678, product_calories: product_calories2)

    recipe = create(:recipe,
                    recipe_products_attributes: [
                      { product_id: product1.id, quantity: 2 },
                      { product_id: product2.id, quantity: 2 },
                    ])

    expect(recipe.recipe_products.find_by[product_id: product1.id].calories).to eq(200)
    expect(recipe.recipe_products.find_by[product_id: product2.id].calories).to eq(400)
  end
end
# rubocop:enable RSpec/ExampleLength
