# frozen_string_literal: true

module Products
  module Validators
    class ProductParams < ::Dry::Validation::Contract
      params do
        required(:name).value(:string, :filled?)
        required(:product_type).value(:string, :filled?, included_in?: Product::PRODUCT_TYPES)
      end
    end
  end
end
