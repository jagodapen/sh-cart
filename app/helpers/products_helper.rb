module ProductsHelper
  
  def types_of_products
    Product.product_types.keys
  end

end
