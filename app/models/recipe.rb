# frozen_string_literal: true

class Recipe < ApplicationRecord
  has_many :recipe_products, dependent: :destroy
  has_many :products, through: :recipe_products
  accepts_nested_attributes_for :recipe_products, reject_if: :all_blank, allow_destroy: true

  after_save :calculate_calories

  def calculate_calories
    Recipes::CalculateRecipeProductsCalories.new(self).call
  end
end
