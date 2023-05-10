# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/shopping_list
class ShoppingListPreview < ActionMailer::Preview
  def shopping_list_email_csv
    ShoppingListMailer.with(shopping_list: ShoppingList.first).shopping_list_email
  end

  def shopping_list_email_pdf
    ShoppingListMailer.with(shopping_list: ShoppingList.last).shopping_list_email
  end
end
