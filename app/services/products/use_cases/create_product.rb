# frozen_string_literal: true

module Products
  module UseCases
    class CreateProduct
      extend ActiveModel::Naming

      def initialize(product)
        @product = product
        @params = @product.attributes.symbolize_keys
        ActiveModel::Errors.new(@product)
      end

      def call
        validate_product_params
        create_product if @validation.errors.empty?
        @product
      end

      private

      # rubocop:disable Style/HashSyntax
      def validate_product_params
        @validation = Products::Validators::ProductParams.new.call(@params)
        @validation.errors.to_h.each do |attribute, message|
          @product.errors.add(attribute, message: message)
        end
      end
      # rubocop:enable Style/HashSyntax

      def create_product
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
