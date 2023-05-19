# frozen_string_literal: true

module Recipes
  module UseCases
    class CalculateRecipeCalories
      def initialize(recipe_products_params:)
        @recipe_products_params = recipe_products_params
      end

      def call
        calculate_recipe_calories
      end

      private

      attr_reader :recipe_products_params

      def calculate_recipe_calories
        calories = 0
        products_calories.each do |product_calories|
          calories += recipe_product_calories(product_calories)
        end
        calories
      end

      def recipe_product_calories(product_calories)
        (products_grams[product_calories.product_id] / 
          product_calories.grams) *
          product_calories.calories
      end

      def products_grams
        recipe_products_params.each_with_object({}) do |params, hash|
          hash[params[:product_id]] = params[:grams]
        end
      end

      def products_calories
        ProductCalories.where(product_id: products_ids).pluck(:product_id, :grams, :calories)
      end

      def products_ids
        products_grams.keys
      end
    end
  end
end
