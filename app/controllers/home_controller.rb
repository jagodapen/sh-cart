class HomeController < ApplicationController
  def index
    @cards = {"Lists": "shopping-lists.svg",
          "Plans": "week-plans.svg",
          "Products": "fav-products.svg",
          "Recipes": "fav-recipes.svg"}
  end
end
