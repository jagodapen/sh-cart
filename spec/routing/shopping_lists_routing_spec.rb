# frozen_string_literal: true

require "rails_helper"

RSpec.describe ShoppingListsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/shopping_lists").to route_to("shopping_lists#index")
    end

    it "routes to #new" do
      expect(get: "/shopping_lists/new").to route_to("shopping_lists#new")
    end

    it "routes to #show" do
      expect(get: "/shopping_lists/1").to route_to("shopping_lists#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/shopping_lists/1/edit").to route_to("shopping_lists#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/shopping_lists").to route_to("shopping_lists#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/shopping_lists/1").to route_to("shopping_lists#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/shopping_lists/1").to route_to("shopping_lists#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/shopping_lists/1").to route_to("shopping_lists#destroy", id: "1")
    end
  end
end
