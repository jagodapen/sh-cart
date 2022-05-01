require 'rails_helper'

RSpec.describe RecipeProduct, type: :model do

  it 'creates recipe_product with defined values' do
    recipe_product = build(:recipe_product)
    expect(recipe_product).to be_valid
  end

  it 'has a quantity equal to 1 if quantity not set' do
    recipe_product = build(:recipe_product)
    expect(recipe_product.quantity).to eq(1)
  end

  it 'has calories equal to 0 if product calories does not exist' do
    recipe_product = build(:recipe_product)
    recipe_product.product.product_calories = nil
    expect(recipe_product.calories).to eq(0)
  end

end
