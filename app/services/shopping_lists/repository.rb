# frozen_string_literal: true

module ShoppingLists
  class Repository
    attr_reader :adapter

    def initialize(adapter: ShoppingList)
      @adapter = adapter
    end

    def all
      adapter.includes(:shopping_list_email).all
    end

    def find(id:)
      adapter.includes(:shopping_list_email, shopping_list_products: :product).find(id)
    end

    def new_entity(attrs: nil)
      adapter.new(attrs)
    end

    def save(shopping_list)
      shopping_list.save
    end

    def delete(shopping_list)
      shopping_list.delete
    end
  end
end
