# frozen_string_literal: true

module ProductsHelper
  def types_of_products
    Product.product_types.keys
  end
end
