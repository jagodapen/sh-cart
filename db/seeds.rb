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
