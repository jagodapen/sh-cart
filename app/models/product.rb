class Product < ApplicationRecord
  has_many :recipe_products
  has_many :recipes, through: :recipe_products
  has_one :product_calories

  has_many :shopping_list_products, dependent: :destroy
  has_many :shopping_lists, through: :shopping_list_products

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :unit, presence: true, length: { maximum: 15 }

  enum :product_type, { fruit: 0, vegetable: 1, nuts: 2, meat: 3, egg: 4, seafood: 5, dairy_products: 6, cereal_products: 7, spices: 8, extras: 9, fat: 10, drink: 11, other: 12 }
end
