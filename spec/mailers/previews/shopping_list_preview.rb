# Preview all emails at http://localhost:3000/rails/mailers/shopping_list
class ShoppingListPreview < ActionMailer::Preview
  def shopping_list_email
    ShoppingListMailer.with(shopping_list: ShoppingList.first).shopping_list_email
  end
end
