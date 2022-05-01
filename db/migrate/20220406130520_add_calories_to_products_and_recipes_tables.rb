class AddCaloriesToProductsAndRecipesTables < ActiveRecord::Migration[7.0]
  def change
    create_table :product_calories do |t|
      t.float :calories
      t.integer :quantity
      t.string :unit
      t.belongs_to :product
    end
    add_column :recipes, :calories, :float
  end
end
