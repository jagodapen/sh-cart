class AddCaloriesToRecipes < ActiveRecord::Migration[7.0]
  def change
    remove_column :recipes, :calories, :float
    add_column :recipes, :calories, :float, null: false, default: 0
  end
end
