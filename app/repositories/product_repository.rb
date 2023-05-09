class ProductRepository
	attr_reader :adapter

	def initialize(adapter: Product)
		@adapter = adapter
	end

	def all
		adapter.all
	end

	def find(id:)
		adapter.find(id)
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
