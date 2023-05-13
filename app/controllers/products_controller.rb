# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_product, only: %i(show edit update destroy)

  def index
    @grouped_products = repository.all_grouped_by_type
  end

  def show; end

  def new
    @product = repository.new_entity
    set_product_types
  end

  def edit
    @product = repository.find(id: params[:id])
    set_product_types
  end

  def create
    @product = repository.new_entity(attrs: product_params)

    respond_to do |format|
      if repository.save(@product)
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    @product = repository.find(id: params[:id])
    @product.attributes = product_params
    respond_to do |format|
      if repository.save(@product)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product = repository.find(id: params[:id])
    repository.delete(@product)

    respond_to do |format|
      format.html { redirect_to products_url, status: :see_other, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
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

  def set_product_types
    @product_types ||= repository.all.product_types.keys
  end
end
