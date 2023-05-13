# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_product, only: %i(show edit update destroy)

  def index
    @grouped_products = repository.all_grouped_by_type
  end

  def show; end

  def new
    @product = repository.new_entity
    @product_types = product_types
  end

  def edit
    @product = repository.find(id: params[:id])
    @product_types = product_types
  end

  def create
    @product = repository.new_entity(attrs: product_params)

    if repository.save(@product)
      redirect_to product_url(@product), notice: "Product was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @product = repository.find(id: params[:id])
    @product.attributes = product_params

    if repository.save(@product)
      redirect_to product_url(@product), notice: "Product was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = repository.find(id: params[:id])
    repository.delete(@product)

    redirect_to products_url, status: :see_other, notice: "Product was successfully destroyed."
  end

  private

  def repository
    @repository ||= Products::Repository.new
  end

  def set_product
    @product = repository.find(id: params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :unit, :product_type)
  end

  def product_types
    repository.all.product_types.keys
  end
end
