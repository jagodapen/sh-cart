# frozen_string_literal: true

require "rails_helper"

RSpec.describe "shopping_lists/edit" do
  let(:shopping_list) { create(:shopping_list, name: "MyString", status: 1) }

  it "renders the edit shopping_list form" do
    render

    assert_select "form[action=?][method=?]", shopping_list_path(shopping_list), "post" do
      assert_select "input[name=?]", "shopping_list[name]"

      assert_select "input[name=?]", "shopping_list[status]"
    end
  end
end
