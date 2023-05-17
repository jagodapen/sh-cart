# frozen_string_literal: true

module Products
  module UseCases
    class CreateProduct
      def initialize(product)
        @product = product
        @params = @product.attributes.symbolize_keys
      end

      def call
        validate_product_params
        if @validation.errors.empty?
          create_product
          fetch_calories
        end
        @product
      end

      private

      # rubocop:disable Style/HashSyntax
      def validate_product_params
        @validation = Products::Validators::CreateProductParams.new.call(@params)
        @validation.errors.to_h.each do |attribute, message|
          @product.errors.add(attribute, message: message)
        end
      end
      # rubocop:enable Style/HashSyntax

      def create_product
        repository.save(@product)
        # @product
      end

      def fetch_calories
        nutritionix_product = Nutritionix::ApiClient.new
        Nutritionix::FetchProductCalories.new(@product, nutritionix_product).call
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
