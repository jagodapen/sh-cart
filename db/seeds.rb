# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# -------creating recipes

Recipe.destroy_all

40.times do
  recipe = Recipe.create(name: Faker::Food.dish,
                        description: Faker::Food.description,
                        preparation_time: Faker::Number.within(range: 1..200).to_i)
  ingridients_num = Faker::Number.within(range: 3..15).to_i
  ingridients_num.times do
    recipe.products << Product.all.sample
  end
end

# -------updating recipes products quantities

RecipeProduct.all.each { |rp| rp.update(quantity: rand(1..200))}

# -------creating products

40.times do
  product = Product.create(name: Faker::Food.ingredient,
                        unit: ["item", "teaspoon", "spoon", "g", "bag", "ml"].sample,
                        product_type: Faker::Number.within(range: 0..12).to_i)

end

# -------creating shopping lists

ShoppingList.destroy_all

20.times do
  shopping_list = ShoppingList.create(name: Faker::Commerce.vendor,
                                      shopping_day: Faker::Date.between(from: 7.days.ago, to: 14.days.from_now),
                                      status: Faker::Number.within(range: 0..1).to_i)
  products_num = Faker::Number.within(range: 3..15).to_i
  products_num.times do
    shopping_list.products << Product.all.sample
  end
end

# -------updating shopping lists products quantities

ShoppingListProduct.all.each { |shlp| shlp.update(quantity: rand(1..200))}
