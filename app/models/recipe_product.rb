class RecipeProduct < ApplicationRecord
  belongs_to :recipe
  belongs_to :product
  counter_culture :recipe, column_name: 'calories', delta_column: 'calories'
end
