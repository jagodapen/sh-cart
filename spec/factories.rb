FactoryBot.define do
  factory(:product) do
    name { Faker::Name.name }
    unit { Faker::Name.unit }
  end
end
