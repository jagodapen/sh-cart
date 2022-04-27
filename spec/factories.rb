FactoryBot.define do
  factory :recipe_product do
    recipe
    product
  end

  factory :recipe do
    name { Faker::Food.dish }
    description { Faker::Food.description }
    preparation_time { Faker::Number.within(range: 1..200).to_i }
  end

  factory :shopping_list do
    name { "MyString" }
    shopping_day { "2022-03-15" }
    status { 1 }
  end

  factory :product do
    name { Faker::Food.ingredient }
    unit { Faker::Food.metric_measurement }
    product_type { rand(0..12) }
  end

  factory :product_calories do
    calories { 528 }
    grams { 115 }
    unit { "some unit" }
    full_name { "Full name" }
    product_id { 1 }
  end


end
