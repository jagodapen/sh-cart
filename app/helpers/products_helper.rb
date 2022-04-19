module ProductsHelper
  def types_of_products
    Product.product_types.keys
  end

  def product_calories(product_id)
    ProductCalories.find_by(product_id: product_id)
  end
end
