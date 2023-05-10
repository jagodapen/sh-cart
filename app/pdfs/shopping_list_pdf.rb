# frozen_string_literal: true

class ShoppingListPdf < Prawn::Document
  include ShoppingListsHelper

  def initialize(shopping_list)
    super()
    @shopping_list = shopping_list
    shopping_list_title
    shopping_list_items
  end

  def shopping_list_title
    text "Darling, please go to", size: 12
    text @shopping_list.name.to_s, size: 16, style: :bold
    text "on #{@shopping_list.shopping_day&.strftime("%a (%d %b)")}", size: 12
    text "and buy:", size: 12
  end

  def shopping_list_items
    move_down 20
    @shopping_list.shopping_list_products.map do |item|
      text "#{item.product.name} - #{item.quantity} #{item.product.unit}", size: 12, style: :italic
    end
  end
end
