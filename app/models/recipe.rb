class Recipe < ApplicationRecord
  has_many :recipe_products
  has_many :products, through: :recipe_products
  # accepts_nested_attributes_for :recipe_products
end
