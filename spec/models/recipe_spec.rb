# frozen_string_literal: true

require "rails_helper"

RSpec.describe Recipe do
  it "creates recipe with given values" do
    recipe = build(:recipe)
    expect(recipe).to be_valid
  end
end
