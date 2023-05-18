# frozen_string_literal: true

module Products
  module Validators
    class UpdateProductParams < ::Dry::Validation::Contract
      params do
        required(:product_type).filled
      end

      rule(:product_type) do
        key.failure("inaccessible") unless value.in?(::Product::PRODUCT_TYPES)
      end
    end
  end
end
