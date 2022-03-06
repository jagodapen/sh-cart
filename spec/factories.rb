FactoryBot.define do
  factory :product do
    name { Faker::Food.ingredient }
    unit { Faker::Food.metric_measurement }
  end
end
