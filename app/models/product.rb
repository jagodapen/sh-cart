class Product < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :unit, presence: true, length: { maximum: 15 }

  enum :product_type, [ :fruit, :vegetable, :nuts, :meat, :egg, :seafood, :dairy_products, :cereal_products, :spices, :extras, :fat, :drink, :other ]
end
