# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProductCalories do
  it "creates product_calories with defined values" do
    product_calories = build(:product_calories)
    expect(product_calories.valid?).to be_true
  end
end
