# frozen_string_literal: true

module Recipes
  module Validators
    class RecipeParams < ::Dry::Validation::Contract
      params do
        required(:name).filled
        optional(:description).maybe(:str?)
        optional(:preparation_time).maybe(:int?)
        required(:recipe_products_attributes).each do
          schema do
            required(:product_id).filled(:int?)
            optional(:quantity).filled(:int?)
            optional(:unit).filled(:str?)
            optional(:grams).filled(:int?)
          end
        end
      end

      rule(:name) do
        key.failure("must consist of letters") unless value.to_i.zero? && value != "0"
      end

      rule(:recipe_products_attributes).each do
        provided_only_one = (value[:quantity].blank? != value[:unit].blank?)
        provided_at_least_one_measure = value[:quantity].present? || value[:grams].present?
        key.failure("Quantity has to be set together with unit") if provided_only_one
        key.failure("Each product must have at least one set: quantity or grams") unless provided_at_least_one_measure
      end
    end
  end
end
