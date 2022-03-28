class CreateShoppingListProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :shopping_list_products do |t|
      t.belongs_to :shopping_list
      t.belongs_to :product
      t.integer :quantity
      
      t.timestamps
    end
  end
end
