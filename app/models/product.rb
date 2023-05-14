# frozen_string_literal: true

class Product < ApplicationRecord
  PRODUCT_TYPES = %w(fruit vegetable nuts meat egg seafood dairy_products cereal_products spices extras fat drink other)

  has_many :recipe_products
  has_many :recipes, through: :recipe_products
  has_one :product_calories

  has_many :shopping_list_products, dependent: :destroy
  has_many :shopping_lists, through: :shopping_list_products

  has_many :shopping_list_products, dependent: :destroy
  has_many :shopping_lists, through: :shopping_list_products

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }

  enum :product_type, { fruit: 0,
                        vegetable: 1,
                        nuts: 2,
                        meat: 3,
                        egg: 4,
                        seafood: 5,
                        dairy_products: 6,
                        cereal_products: 7,
                        spices: 8,
                        extras: 9,
                        fat: 10,
                        drink: 11,
                        other: 12 }

  after_save :fetch_calories

  def fetch_calories
    nutritionix_product = Nutritionix::ApiClient.new
    Nutritionix::FetchProductCalories.new(self, nutritionix_product).call
  end
end
