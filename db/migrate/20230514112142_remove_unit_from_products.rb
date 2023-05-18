class RemoveUnitFromProducts < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :unit, :string
  end
end
