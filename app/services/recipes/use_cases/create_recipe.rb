# frozen_string_literal: true

module Recipes
  module UseCases
    class CreateRecipe
      def initialize(recipe, params)
        @recipe = recipe
        @params = params
      end

      def call
        validate_recipe_params
        if @validation.errors.empty?
          ActiveRecord::Base.transaction do
            create_recipe
            create_recipe_products
          end
        end
        @recipe
      end

      private

      attr_reader :recipe, :params

      def validate_recipe_params
        @validation = Recipes::Validators::RecipeParams.new.call(converted_params)
        @validation.errors.to_h.each do |attribute, message|
          recipe.errors.add(attribute, message:) unless attribute == :recipe_products_attributes

            message.each do |_, recipe_products_attributes_error|
              unless recipe.errors.messages[:base].include?(recipe_products_attributes_error&.first)
                recipe.errors.add(:base, message: recipe_products_attributes_error)
              end
            end
        end
      end

      def converted_params
        @converted_params ||= {
          name: params[:name],
          description: params[:description].blank? ? nil : params[:description],
          preparation_time: params[:preparation_time].blank? ? nil : params[:preparation_time].to_i,
          recipe_products_attributes: recipe_products_params,
        }.compact
      end

      def create_recipe
        @recipe = repository.new_entity(attrs: new_recipe_params)
        repository.save(@recipe)
      rescue Base::Repository::RepositoryError => e
        recipe.errors.add(:base, message: e.message)
      end

      def new_recipe_params
        @new_recipe_params ||= converted_params.merge({recipe_products_attributes: []})
      end

      def create_recipe_products
        return unless recipe.errors.empty?

        recipe_products_params_with_calories.each do |product_params|
          RecipeProduct.create!(product_params)
        end
      end

      def recipe_products_params_with_calories
        products_calories = Recipes::UseCases::CalculateRecipeProductsCalories.new(recipe_products_params).call
        recipe_products_params.map do |params|
          params.merge(
            {
              calories: products_calories[params[:product_id]],
              recipe_id: @recipe.id,
            }
          ).except(:_destroy)
        end
      end

      def recipe_products_params
        @recipe_products_params ||= params[:recipe_products_attributes].values.each_with_object([]) do |params, arr| 
          arr.push({
            product_id: params[:product_id].to_i,
            quantity: params[:quantity].blank? ? nil : params[:quantity].to_i,
            unit: params[:unit].blank? ? nil : params[:unit],
            grams: params[:grams].blank? ? nil : params[:grams].to_i,
          }.compact)
        end
      end

      def repository
        @repository ||= Recipes::Repository.new
      end
    end
  end
end
