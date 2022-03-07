class AddValidationToProducts < ActiveRecord::Migration[7.0]
  def change
    change_column :products, :name, :string, null: false
    change_column :products, :unit, :string, null: false
  end
end
