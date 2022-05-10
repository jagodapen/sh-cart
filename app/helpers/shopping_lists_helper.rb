module ShoppingListsHelper
  def shopping_list_statuses
    @shopping_list_statuses ||= ShoppingList.statuses.keys
  end

  def shopping_list_file_formats
    @shopping_list_file_formats ||= ShoppingListEmail.file_formats.keys
  end

  def product(id)
    Product.find(id)
  end
end
