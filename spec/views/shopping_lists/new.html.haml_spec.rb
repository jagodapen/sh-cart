# frozen_string_literal: true

require "rails_helper"

RSpec.describe "shopping_lists/new" do
  before { create(:shopping_list, name: "MyString", status: 1) }

  it "renders new shopping_list form" do
    render

    assert_select "form[action=?][method=?]", shopping_lists_path, "post" do
      assert_select "input[name=?]", "shopping_list[name]"

      assert_select "input[name=?]", "shopping_list[status]"
    end
  end
end
