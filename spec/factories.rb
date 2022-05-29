# rubocop:disable Metrics/BlockLength
FactoryBot.define do
  factory :recipe_product do
    quantity { rand(1..5) }
    recipe
    product
  end

  factory :recipe do
    name { Faker::Food.dish }
    description { Faker::Food.description }
    preparation_time { Faker::Number.within(range: 1..200).to_i }
    transient do
      recipe_product { create(:recipe_product) }
    end
  end

  factory :shopping_list do
    name { 'MyString' }
    shopping_day { '2022-03-15' }
    status { 1 }
  end

  factory :product do
    name { Faker::Food.ingredient }
    unit { Faker::Food.metric_measurement }
    product_type { rand(0..12) }
    transient do
      product_calories { create(:product_calories) }
    end
  end

  factory :product_calories do
    calories { 125 }
    grams { rand(1..200) }
    unit { 'some unit' }
    full_name { 'Full name' }
    product
  end
end
# rubocop:enable Metrics/BlockLength
