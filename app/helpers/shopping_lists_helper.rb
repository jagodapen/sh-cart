module ShoppingListsHelper

  def shopping_list_statuses
    @shopping_list_statuses ||= ShoppingList.statuses.keys
  end

end
