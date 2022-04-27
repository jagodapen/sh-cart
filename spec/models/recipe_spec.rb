require 'rails_helper'

RSpec.describe Recipe, type: :model do

  it 'creates recipe with given values' do
    recipe = build(:recipe)
    expect(recipe).to be_valid
  end

  it 'calculates calories' do
    #Arranging data
    recipe = build(:recipe)
    #Act
    result = recipe.calculate_calories
    #Assert
    expect(result).to eq(recipe.calories)
  end

end
