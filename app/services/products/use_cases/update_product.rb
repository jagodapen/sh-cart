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
        update_product if @product.errors.empty?
        @product
      end

      private

      # rubocop:disable Style/HashSyntax
      def validate_product_params
        @validation = Products::Validators::UpdateProductParams.new.call(product_params)
        @validation.errors.to_h.each do |attribute, message|
          @product.errors.add(attribute, message: message)
        end
        @product.errors.add(:name, message: "Renaming is not allowed") if name_changed?
      end
      # rubocop:enable Style/HashSyntax

      def update_product
        @product.attributes = product_params
        repository.save(@product)
      end

      def product_params
        { product_type: @params[:product_type] }.compact
      end

      def repository
        @repository ||= Products::Repository.new
      end

      def name_changed?
        @params[:name] != @product.name
      end
    end
  end
end
