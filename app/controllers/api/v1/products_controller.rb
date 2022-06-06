module Api
  module V1
    class ProductsController < BaseApiController
      def index
        products = Product.all
        render json: products
      end
    end
  end
end
