# frozen_string_literal: true

module Products
  module UseCases
    class DeleteProduct
      def initialize(product_id)
        @product_id = product_id
        @product = repository.find(id: product_id)
      end

      def call
        delete_product_calories
        delete_product
      end

      private

      def delete_product_calories
        ProductCalories.find_by(product_id: @product_id)&.delete
      end

      def delete_product
        repository.delete(@product)
      end

      def repository
        @repository ||= Products::Repository.new
      end
    end
  end
end
