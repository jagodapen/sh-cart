class EditRecipesPreparationTimeDatatype < ActiveRecord::Migration[7.0]
  def change
    remove_column :recipes, :preparation_time, :time
    add_column :recipes, :preparation_time, :integer
  end
end
