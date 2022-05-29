require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the RecipesHelper. For example:
#
# describe RecipesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe RecipesHelper, type: :helper do
  include RecipesHelper
  it 'converts preparation time to hours&minutes format' do
    recipe = build(:recipe, preparation_time: 164)
    result = preparation_time_hours(recipe.preparation_time)
    expect(result).to eq('2h 44min')
  end
end
