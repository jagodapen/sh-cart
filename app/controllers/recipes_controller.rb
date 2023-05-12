# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :set_recipe, only: %i(show edit update destroy)

  def index
    @recipes = repository.all
  end

  def show; end

  def new
    @recipe = repository.new_entity
    build_recipe_product
  end

  def edit
    build_recipe_product
  end

  def create
    @recipe = repository.new_entity(attrs: recipe_params)

    if repository.save(@recipe)
      redirect_to recipe_url(@recipe), notice: "Recipe was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @recipe.attributes = recipe_params

    if repository.save(@recipe)
      redirect_to recipe_url(@recipe), notice: "Recipe was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    repository.delete(@recipe)

    redirect_to recipes_url, notice: "Recipe was successfully destroyed."
  end

  private

  def repository
    RecipeRepository.new
  end

  def set_recipe
    @recipe = repository.find(id: params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :preparation_time,
                                   recipe_products_attributes:
                                   %i(id recipe_id product_id quantity calories _destroy))
  end

  def build_recipe_product
    @recipe_product = @recipe.recipe_products.build
  end
end
