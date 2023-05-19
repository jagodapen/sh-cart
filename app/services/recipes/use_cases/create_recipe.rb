# frozen_string_literal: true

module Recipes
  module UseCases
    class CreateRecipe
      def initialize(recipe)
        @recipe = recipe
        @params = @recipe.attributes.symbolize_keys
      end

      def call
        validate_recipe_params
        if @validation.errors.empty?
          create_recipe
          calculate_recipe_calories
        end
        @recipe
      end

      private

      def validate_recipe_params
        @validation = Recipes::Validators::RecipeParams.new.call(recipe_params)
        @validation.errors.to_h.each do |attribute, message|
          @recipe.errors.add(attribute, message:)
        end
      end

      def create_recipe
        repository.save(@recipe)
      end

      def recipe_params
        {
          name: @params[:name],
          description: @params[:description].blank? ? nil : @params[:description],
          preparation_time: @params[:preparation_time].blank? ? nil : @params[:preparation_time],
        }.compact
      end

      def calculate_recipe_calories
        Recipes::UseCases::CalculateRecipeCalories.call(recipe_products_params:)
      end

      def recipe_products_params
        params[:recipe_products_attributes].values
      end

      def repository
        @repository ||= Recipes::Repository.new
      end
    end
  end
end
