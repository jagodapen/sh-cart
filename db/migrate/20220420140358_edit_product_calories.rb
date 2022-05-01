class EditProductCalories < ActiveRecord::Migration[7.0]
  def change
    rename_column :product_calories, :quantity, :grams
    add_column :product_calories, :full_name, :string
  end
end
