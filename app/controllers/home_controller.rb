class HomeController < ApplicationController
  def index
    @cards = {"lists": "shopping-lists.svg",
              "plans": "week-plans.svg",
              "products": "fav-products.svg",
              "recipes": "fav-recipes.svg"}
  end
end
