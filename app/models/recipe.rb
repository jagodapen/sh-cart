class Recipe < ApplicationRecord
  has_many :recipe_products
  has_many :products, through: :recipe_products
end
