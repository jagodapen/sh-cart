# frozen_string_literal: true

module Products
  module UseCases
    class CreateProduct
      InvalidParams = Class.new(StandardError)

      def initialize(params)
        @params = params
      end

      def call
        validate_product_params
        create_product
      end

      private

      def validate_product_params
        validation = Products::Validators::ProductParams.new.call(@params)

        raise InvalidParams, "Invalid params" if validation.errors.any?
      end

      def create_product
        product = repository.new_entity(attrs: product_params)
        repository.save(product)
      end

      def product_params
        {
          name: @params[:name],
          product_type: @params[:product_type],
        }.compact
      end

      def repository
        @repository ||= Products::Repository.new
      end
    end
  end
end
