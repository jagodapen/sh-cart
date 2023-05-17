# frozen_string_literal: true

module Products
  module Validators
    class ProductParams < ::Dry::Validation::Contract
      params do
        required(:name).filled.value(:str?)
        required(:product_type).filled.value(included_in?: Product::PRODUCT_TYPES)
      end

      rule(:name) do
        key.failure("must consist of letters") unless value.to_i.zero? && value != "0"
      end
    end
  end
end
