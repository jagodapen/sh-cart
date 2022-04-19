class AddCaloriesToRecipeProducts < ActiveRecord::Migration[7.0]
  def self.up
    add_column :recipe_products, :calories, :integer, null: false, default: 0
  end

  def self.down
    remove_column :recipe_products, :calories
  end
end
