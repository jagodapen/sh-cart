# frozen_string_literal: true

require "rails_helper"

RSpec.describe "recipes/new" do
  before { create(:recipe, name: "MyString", description: "MyText") }

  it "renders new recipe form" do
    render

    assert_select "form[action=?][method=?]", recipes_path, "post" do
      assert_select "input[name=?]", "recipe[name]"

      assert_select "textarea[name=?]", "recipe[description]"
    end
  end
end
