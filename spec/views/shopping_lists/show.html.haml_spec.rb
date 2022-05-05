require 'rails_helper'

RSpec.describe 'shopping_lists/show', type: :view do
  before(:each) do
    @shopping_list = assign(:shopping_list, ShoppingList.create!(
                                              name: 'Name',
                                              status: 2
                                            ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
  end
end
