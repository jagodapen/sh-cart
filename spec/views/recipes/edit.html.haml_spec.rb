# frozen_string_literal: true

require "rails_helper"

RSpec.describe "recipes/edit" do
  let(:recipe) { create(:recipe, name: "MyString", description: "MyText") }

  it "renders the edit recipe form" do
    render

    assert_select "form[action=?][method=?]", recipe_path(recipe), "post" do
      assert_select "input[name=?]", "recipe[name]"

      assert_select "textarea[name=?]", "recipe[description]"
    end
  end
end
