require 'rails_helper'

RSpec.describe ProductCalories, type: :model do
  it 'creates product_calories with defined values' do
    product_calories = build(:product_calories)
    expect(product_calories.valid?).to eq true
  end
end
