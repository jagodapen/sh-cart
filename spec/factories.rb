FactoryBot.define do
  factory :recipe do
    name { "MyString" }
    description { "MyText" }
    preparation_time { "2022-03-17 13:55:36" }
  end

  factory :shopping_list do
    name { "MyString" }
    shopping_day { "2022-03-15" }
    status { 1 }
  end

  factory :product do
    name { Faker::Food.ingredient }
    unit { Faker::Food.metric_measurement }
  end
end
