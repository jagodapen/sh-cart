# frozen_string_literal: true

class ShoppingList < ApplicationRecord
  attr_accessor :send_email

  has_many :shopping_list_products, dependent: :destroy
  has_many :products, through: :shopping_list_products
  has_one :shopping_list_email, dependent: :destroy
  accepts_nested_attributes_for :shopping_list_products, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :shopping_list_email, reject_if: :all_blank, allow_destroy: true
  enum :status, { pending: 0, done: 1 }
end
