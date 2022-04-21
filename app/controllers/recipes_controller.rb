class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show edit update destroy ]
  # after_action :calculate_recipe_product_calories, only: %i[ create update ]
  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.all
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    @recipe_products = RecipeProduct.where(recipe_id: @recipe)
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
    5.times { @recipe.recipe_products.build }
    @recipe_product = RecipeProduct.new
  end

  # GET /recipes/1/edit
  def edit
    @recipe_product = RecipeProduct.new
  end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        Recipes::CalculateRecipeCalories.new(@recipe).call
        format.html { redirect_to recipe_url(@recipe), notice: "Recipe was successfully created." }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        Recipes::CalculateRecipeCalories.new(@recipe).call
        format.html { redirect_to recipe_url(@recipe), notice: "Recipe was successfully updated." }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url, notice: "Recipe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
      params.require(:recipe).permit(:name, :description, :preparation_time,
                                      recipe_products_attributes: [:id, :recipe_id, :product_id, :quantity, :calories, :_destroy])
    end

end
