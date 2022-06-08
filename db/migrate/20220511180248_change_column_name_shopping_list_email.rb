class ChangeColumnNameShoppingListEmail < ActiveRecord::Migration[7.0]
  def change
    rename_column :shopping_list_emails, :send, :was_send
  end
end
