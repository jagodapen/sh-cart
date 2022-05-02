require 'rails_helper'

RSpec.describe Recipe do

  it 'calculates recipe products calories' do

    product_calories_data = {"food_name"=>"brie",
                             "serving_qty"=>1,
                             "serving_unit"=>"oz",
                             "serving_weight_grams"=>28.35,
                             "nf_calories"=>100}
    allow_any_instance_of(Nutritionix::ApiClient).to receive(:get_product_data).and_return(product_calories_data)
    product = create(:product)

    recipe = create(:recipe)

    expect(recipe.calories).to eq(500)
  end
end
