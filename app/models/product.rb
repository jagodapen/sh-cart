class Product < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :unit, presence: true, length: { maximum: 15 }
end
