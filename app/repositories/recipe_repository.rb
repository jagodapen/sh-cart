class RecipeRepository
  attr_reader :adapter

  def initialize(adapter: Recipe)
    @adapter = adapter
  end

  def all
    adapter.all
  end

  def find(id:)
    adapter.includes(recipe_products: :product).find(id)
  end

  def new_entity(attrs: nil)
    adapter.new(attrs)
  end

  def save(recipe)
    recipe.save
  end

  def delete(recipe)
    recipe.delete
  end
end
