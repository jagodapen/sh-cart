# frozen_string_literal: true

require "rails_helper"

RSpec.describe "shopping_lists/show" do
  before { assign(:shopping_list, create(:shopping_list, name: "Name", status: 2)) }

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
  end
end
