# frozen_string_literal: true

module Recipes
  class Repository < Base::Repository
    attr_reader :adapter

    def initialize(adapter: Recipe)
      super()
      @adapter = adapter
    end

    def all
      adapter.all
    end

    def find(id:)
      adapter.includes(recipe_products: :product).find(id)
    rescue ActiveRecord::RecordInvalid => e
      raise_error(e.message)
    end

    def new_entity(attrs: nil)
      adapter.new(attrs)
    end

    def save(recipe)
      recipe.save
    rescue ActiveRecord::RecordInvalid => e
      raise_error(e.message)
    end

    def delete(recipe)
      recipe.destroy
    end
  end
end
