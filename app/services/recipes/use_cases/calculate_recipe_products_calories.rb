# frozen_string_literal: true

module Recipes
  module UseCases
    class CalculateRecipeProductsCalories
      def initialize(recipe_products_params)
        @recipe_products_params = recipe_products_params
      end

      def call
        calculate_recipe_products_calories
      end

      private

      attr_reader :recipe_products_params

      def calculate_recipe_products_calories
        products_calories.each_with_object({}) do |calories, hash|
          hash[calories.product_id] = recipe_product_calories(calories)
        end
      end

      def products_calories
        @products_calories ||= ProductCalories.where(product_id: products_ids).select(:product_id, :grams, :calories)
      end

      def products_ids
        products_grams.keys
      end

      def products_grams
        recipe_products_params.each_with_object({}) do |params, hash|
          next unless params[:grams]

          hash[params[:product_id].to_i] = params[:grams].to_i
        end
      end

      def recipe_product_calories(product_calories_data)
        (products_grams[product_calories_data.product_id] / 
          product_calories_data.grams.to_f) *
          product_calories_data.calories.round
      end
    end
  end
end
