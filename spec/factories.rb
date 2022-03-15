FactoryBot.define do
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
