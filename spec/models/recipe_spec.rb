require 'rails_helper'

RSpec.describe Recipe, type: :model do

  it 'creates recipe with given values' do
    recipe = build(:recipe)
    expect(recipe).to be_valid
  end

end
