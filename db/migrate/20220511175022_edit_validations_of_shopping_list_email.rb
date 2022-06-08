class EditValidationsOfShoppingListEmail < ActiveRecord::Migration[7.0]
  def change
    change_column_null :shopping_list_emails, :shopping_list_id, true
  end
end
