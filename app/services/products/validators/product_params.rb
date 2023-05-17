# frozen_string_literal: true

module Products
  module Validators
    class ProductParams < ::Dry::Validation::Contract
      params do
        required(:name).filled.value(:str?)
        required(:product_type).filled.value(:str?, included_in?: Product::PRODUCT_TYPES)
      end
    end
  end
end
