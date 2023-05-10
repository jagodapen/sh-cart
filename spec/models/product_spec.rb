# frozen_string_literal: true

require "rails_helper"

RSpec.describe Product do
  it "creates product with defined values" do
    product = build(:product)
    expect(product.valid?).to be_true
  end

  it "refuse to create product with empty name" do
    product = build(:product, name: "")
    expect(product.valid?).to be_false
  end

  it "refuse to create product with empty unit" do
    product = build(:product, unit: "")
    expect(product.valid?).to be_false
  end
end
