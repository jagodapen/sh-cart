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

end
