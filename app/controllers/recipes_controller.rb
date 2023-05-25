# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :set_recipe, only: %i(update destroy)

  def index
    @recipes = repository.all
    @converted_preparation_times = create_converted_preparation_times_hash(@recipes)
  end

  def show
    @recipe = repository.find(id: params[:id])
    @preparation_time = converted_preparation_time(@recipe)
  end

  def new
    @recipe = repository.new_entity
    build_recipe_product
    @all_products = products_repository.all
  end

  def edit
    @recipe = repository.find(id: params[:id])
    build_recipe_product
    @all_products = products_repository.all
  end

  def create
    @recipe = repository.new_entity(attrs: recipe_params)
    @all_products = products_repository.all
    @recipe = Recipes::UseCases::CreateRecipe.new(@recipe, recipe_params).call

    if @recipe.errors.any?
      build_recipe_product
      render :new, status: :unprocessable_entity, alert: @recipe.errors.messages
    else
      redirect_to recipe_url(@recipe), notice: "Recipe was successfully created."
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
    @repository ||= Recipes::Repository.new
  end

  def products_repository
    @products_repository ||= Products::Repository.new
  end

  def set_recipe
    @recipe = repository.find(id: params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(
      :name,
      :description,
      :preparation_time,
      recipe_products_attributes: %i(
        id
        recipe_id
        product_id
        quantity
        calories
        unit
        grams
        _destroy
      )
    )
  end

  def build_recipe_product
    @recipe_product = @recipe.recipe_products.build
  end

  def converted_preparation_time(recipe)
    Recipes::Representers::PreparationTime.new(recipe.preparation_time).call
  end

  def create_converted_preparation_times_hash(recipes)
    recipes.each_with_object({}) do |recipe, hash|
      hash[recipe.id] = converted_preparation_time(recipe)
    end
  end
end
