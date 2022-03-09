module ProductsHelper

  def product_type_haml_id(name)
    @product_type_haml_id = "product_type_" + name
  end

  def products_of_type(name)
    @products_of_type = Product.where(product_type: name)
  end

end
