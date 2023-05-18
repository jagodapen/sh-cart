# frozen_string_literal: true

module Products
  module Validators
    class CreateProductParams < ::Dry::Validation::Contract
      params do
        required(:name).filled.value(:str?)
        required(:product_type).filled
      end

      rule(:name) do
        key.failure("must consist of letters") unless value.to_i.zero? && value != "0"
      end

      rule(:product_type) do
        key.failure("inaccessible") unless value.in?(::Product::PRODUCT_TYPES)
      end
    end
  end
end
