class AddDefaultValueForShoppingListStatusAndName < ActiveRecord::Migration[7.0]
  def change
    change_column :shopping_lists, :name, :string, default: "shopping list"
    change_column :shopping_lists, :status, :integer, default: 0
  end
end
