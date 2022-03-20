class CreateRecipeProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_products do |t|
      t.integer :recipe_id
      t.integer :product_id
      t.integer :quantity
    end
  end
end
