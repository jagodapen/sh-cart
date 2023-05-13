# frozen_string_literal: true

module Products
  class Repository
    attr_reader :adapter

    def initialize(adapter: Product)
      @adapter = adapter
    end

    def all
      adapter.all
    end

    def all_grouped_by_type
      adapter.includes(:product_calories).all.group_by(&:product_type)
    end

    def find(id:)
      adapter.includes(:product_calories, :recipes).find(id)
    end

    def new_entity(attrs: nil)
      adapter.new(attrs)
    end

    def save(product)
      product.save
    end

    def delete(product)
      product.delete
    end
  end
end
