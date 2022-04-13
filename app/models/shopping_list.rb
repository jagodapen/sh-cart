class ShoppingList < ApplicationRecord
  has_many :shopping_list_products, dependent: :destroy
  has_many :products, through: :shopping_list_products
  accepts_nested_attributes_for :shopping_list_products, reject_if: :all_blank, allow_destroy: true
  enum :status, { pending: 0, done: 1 }
end
