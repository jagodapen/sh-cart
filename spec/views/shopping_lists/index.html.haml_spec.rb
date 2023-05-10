# frozen_string_literal: true

require "rails_helper"

RSpec.describe "shopping_lists/index" do
  before do
    create(:shopping_list, name: "Name1", status: 1)
    create(:shopping_list, name: "Name2", status: 1)
  end

  it "renders a list of shopping_lists" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
  end
end
