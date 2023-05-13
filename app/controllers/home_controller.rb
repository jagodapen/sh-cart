# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @home_cards = %i(shopping_lists plans products recipes)
  end
end
