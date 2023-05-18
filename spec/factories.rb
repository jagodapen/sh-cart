# frozen_string_literal: true

FactoryBot.define do
  factory :recipe_product do
    quantity { rand(1..5) }
    recipe
    product { create(:product) }
  end

  factory :recipe do
    name { Faker::Food.dish }
    description { Faker::Food.description }
    preparation_time { Faker::Number.within(range: 1..200).to_i }

    trait :with_products do
      after(:create) do |recipe|
        2.times { recipe.products << FactoryBot.create(:product) }
        recipe.recipe_products.each { |i| i.update(quantity: rand(1..10), calories: rand(20..100)) }
      end
    end

    factory :recipe_with_2_products, traits: [:with_products]
  end

  factory :shopping_list do
    name { Faker::Commerce.vendor }
    shopping_day { Time.new.next_day(2) }
    status { "pending" }

    trait :with_products do
      after(:create) do |shopping_list|
        2.times { shopping_list.products << FactoryBot.create(:product) }
        shopping_list.shopping_list_products.each { |i| i.update(quantity: rand(1..10)) }
      end
    end

    factory :shopping_list_with_2_products, traits: [:with_products]
  end

  factory :product do
    name { Faker::Food.ingredient }
    product_type { rand(0..12) }

    trait :with_calories do
      after(:create) do |product|
        create(:product_calories, product:)
      end
    end

    factory :product_with_calories, traits: [:with_calories]
  end

  factory :product_calories do
    calories { 125 }
    grams { rand(1..200) }
    unit { "some unit" }
    full_name { "Full name" }
    product
  end

  factory :shopping_list_email do
    send_date { Time.new.next_day(1) }
    file_format { 0 }
    recipient { "example@email.com" }
    was_send { false }
  end
end
