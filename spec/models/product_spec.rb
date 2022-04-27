require 'rails_helper'

RSpec.describe Product, type: :model do

  it 'creates product with defined values' do
    product = build(:product)
    expect(product.valid?).to eq true
  end

  it 'refuse to create product with empty name' do
    product = build(:product, name: "")
    expect(product.valid?).to eq false
  end

  it 'refuse to create product with empty unit' do
    product = build(:product, unit: "")
    expect(product.valid?).to eq false
  end

#not working
  describe '#fetch_calories' do
    it 'sends request to NutritionixAPI for calories data and saves it' do
      allow(Calories::FetchProductCalories.new(self)).to receive(:call)
      product = create(:product)
      expect(Calories::FetchProductCalories.new(self)).to receive(:call)
      expect(product.product_calories).to be_truthy
    end
  end

end
