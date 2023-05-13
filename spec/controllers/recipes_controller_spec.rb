# frozen_string_literal: true

require "rails_helper"

RSpec.describe Recipe, type: :request do
  describe "GET #index" do
    # rubocop:disable RSpec/ExampleLength
    it "shows all recipes" do
      recipe1 = create(:recipe, preparation_time: 20)
      recipe2 = create(:recipe, preparation_time: 30)

      get recipes_path

      expect(response).to be_successful
      expect(response.body).to include(recipe1.name)
      expect(response.body).to include(recipe1.preparation_time.to_s)
      expect(response.body).to include(recipe2.name)
      expect(response.body).to include(recipe2.preparation_time.to_s)
    end
  end

  describe "GET #new" do
    it "renders form" do
      get new_recipe_path

      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "renders form" do
      recipe = create(:recipe)

      get edit_recipe_path(recipe)

      expect(response).to be_successful
      expect(response.body).to include(recipe.name)
      expect(response.body).to include(recipe.preparation_time.to_s)
      expect(response.body).to include(recipe.description)
    end
  end

  describe "GET #show" do
    it "shows recipe" do
      recipe = create(:recipe, preparation_time: 20)

      get recipe_path(recipe)

      expect(response).to be_successful
      expect(response.body).to include(recipe.name)
      expect(response.body).to include(recipe.preparation_time.to_s)
      expect(response.body).to include(recipe.description)
    end
  end

  describe "POST #create" do
    it "creates new recipe" do
      product1 = create(:product)
      product2 = create(:product)
      params = {
        recipe: {
          name: "Recipe 1",
          descritpion: "some description",
          preparation_time: 100,
          recipe_products_attributes: {
            "1": { product_id: product1.id, quantity: 1 },
            "2": { product_id: product2.id, quantity: 2 },
          },
        },
      }

      post recipes_path params

      expect(response).to redirect_to(recipe_path(described_class.last))
      expect(described_class.all.count).to eq 1
      expect(described_class.last.products.count).to eq 2
    end
  end

  describe "PUT #update" do
    it "updates recipe" do
      recipe = create(:recipe)
      product = create(:product)
      new_params = {
        recipe: {
          name: "new recipe name",
          descritpion: "some description",
          preparation_time: 100,
          recipe_products_attributes: {
            "1": { product_id: product.id, quantity: 1 },
          },
        },
      }

      put recipe_path(recipe), params: new_params

      expect(response).to redirect_to(recipe_path(recipe))
      expect(recipe.reload.name).to eq "new recipe name"
      expect(described_class.last.products.count).to eq 1
    end
  end
  # rubocop:enable RSpec/ExampleLength

  describe "DELETE #destroy" do
    it "destroy recipe" do
      recipe = create(:recipe)

      delete recipe_path(recipe)

      expect(response).to redirect_to(recipes_path)
      expect(described_class.all.count).to eq 0
    end
  end
end
