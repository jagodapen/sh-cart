class ChangeRecipeProductQuantity < ActiveRecord::Migration[7.0]
  def change
    change_column :recipe_products, :quantity, :integer, default: 1, null: false
  end
end
