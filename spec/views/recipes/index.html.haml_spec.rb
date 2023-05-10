# frozen_string_literal: true

require "rails_helper"

RSpec.describe "recipes/index" do
  let(:recipes) do
    [
      create(:recipe, name: "Name1", description: "MyText1"),
      create(:recipe, name: "Name2", description: "MyText2"),
    ]
  end

  it "renders a list of recipes" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
  end
end
