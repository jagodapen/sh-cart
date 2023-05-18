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
          create_product_calories
        end
        @product
      end

      private

      def validate_product_params
        @validation = Products::Validators::CreateProductParams.new.call(@params)
        @validation.errors.to_h.each do |attribute, message|
          @product.errors.add(attribute, message:)
        end
      end

      def create_product
        repository.save(@product)
      end

      def create_product_calories
        product_info = fetch_calories
        ProductCalories.create(
          product_id: @product.id,
          calories: product_info["nf_calories"],
          unit: product_info["serving_unit"],
          grams: product_info["serving_weight_grams"],
          full_name: product_info["food_name"],
        )
      end

      def fetch_calories
        api_client = Nutritionix::ApiClient.new
        Nutritionix::FetchProductCalories.new(product_name: @product.name, api_client:).call
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
