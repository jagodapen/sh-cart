include ShoppingListsHelper
class ShoppingListPdf < Prawn::Document
  def initialize(shopping_list)
    super()
    @shopping_list = shopping_list
    shopping_list_title
    shopping_list_items
  end

  def shopping_list_title
    text "Darling, please go to", size: 12
    text "#{@shopping_list.name}", size: 16, style: :bold
    text "on #{@shopping_list.shopping_day&.strftime('%a (%d %b)')}", size: 12
    text "and buy:", size: 12
  end

  def shopping_list_items
    move_down 20
    @shopping_list.shopping_list_products.map do |item|
      text "#{Product.find(item.product_id).name} - #{item.quantity} #{Product.find(item.product_id).unit}", size: 12,
                                                                                                            style: :italic
    end
  end
end
