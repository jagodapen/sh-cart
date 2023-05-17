# frozen_string_literal: true

module Products
  module UseCases
    class UpdateProduct
      def initialize(product, params)
        @product = product
        @params = params
      end

      def call
        validate_product_params
        update_product if @validation.errors.empty?
        @product
      end

      private

      # rubocop:disable Style/HashSyntax
      def validate_product_params
        @validation = Products::Validators::ProductParams.new.call(product_params)
        @validation.errors.to_h.each do |attribute, message|
          @product.errors.add(attribute, message: message)
        end
      end
      # rubocop:enable Style/HashSyntax

      def update_product
        @product.attributes = product_params
        repository.save(@product)
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
