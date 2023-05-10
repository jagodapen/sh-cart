# frozen_string_literal: true

require "rails_helper"

RSpec.describe "recipes/show" do
  before { assign(:recipe, create(:recipe, name: "Name", description: "MyText")) }

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
  end
end
