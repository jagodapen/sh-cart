# frozen_string_literal: true

class ShoppingListProduct < ApplicationRecord
  belongs_to :shopping_list
  belongs_to :product
end
