# frozen_string_literal: true

module Recipes
  module Validators
    class RecipeParams < ::Dry::Validation::Contract
      params do
        required(:name).filled(:str?)
        optional(:description).maybe(:str?)
        optional(:preparation_time).maybe(:int?)
      end

      rule(:name) do
        key.failure("must consist of letters") unless value.to_i.zero? && value != "0"
      end
    end
  end
end
