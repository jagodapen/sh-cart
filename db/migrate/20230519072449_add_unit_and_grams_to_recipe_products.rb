class AddUnitAndGramsToRecipeProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :recipe_products, :unit, :string
    add_column :recipe_products, :grams, :integer
  end
end
