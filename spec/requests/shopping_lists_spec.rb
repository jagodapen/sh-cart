# frozen_string_literal: true

require "rails_helper"
# rubocop:disable Metrics/BlockLength
# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we"re
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/shopping_lists" do
  # This should return the minimal set of attributes required to create a valid
  # ShoppingList. As you add validations to ShoppingList, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    skip("Add a hash of attributes valid for your model")
  end

  let(:invalid_attributes) do
    skip("Add a hash of attributes invalid for your model")
  end

  describe "GET /index" do
    it "renders a successful response" do
      ShoppingList.create! valid_attributes
      get shopping_lists_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      shopping_list = ShoppingList.create! valid_attributes
      get shopping_list_url(shopping_list)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_shopping_list_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      shopping_list = ShoppingList.create! valid_attributes
      get edit_shopping_list_url(shopping_list)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new ShoppingList" do
        expect do
          post shopping_lists_url, params: { shopping_list: valid_attributes }
        end.to change(ShoppingList, :count).by(1)
      end

      it "redirects to the created shopping_list" do
        post shopping_lists_url, params: { shopping_list: valid_attributes }
        expect(response).to redirect_to(shopping_list_url(ShoppingList.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new ShoppingList" do
        expect do
          post shopping_lists_url, params: { shopping_list: invalid_attributes }
        end.not_to change
      end

      it "renders a successful response" do
        post shopping_lists_url, params: { shopping_list: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        skip("Add a hash of attributes valid for your model")
      end

      it "updates the requested shopping_list" do
        shopping_list = ShoppingList.create! valid_attributes
        patch shopping_list_url(shopping_list), params: { shopping_list: new_attributes }
        shopping_list.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the shopping_list" do
        shopping_list = ShoppingList.create! valid_attributes
        patch shopping_list_url(shopping_list), params: { shopping_list: new_attributes }
        shopping_list.reload
        expect(response).to redirect_to(shopping_list_url(shopping_list))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response" do
        shopping_list = ShoppingList.create! valid_attributes
        patch shopping_list_url(shopping_list), params: { shopping_list: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested shopping_list" do
      shopping_list = ShoppingList.create! valid_attributes
      expect do
        delete shopping_list_url(shopping_list)
      end.to change(ShoppingList, :count).by(-1)
    end

    it "redirects to the shopping_lists list" do
      shopping_list = ShoppingList.create! valid_attributes
      delete shopping_list_url(shopping_list)
      expect(response).to redirect_to(shopping_lists_url)
    end
  end
end
# rubocop:enable Metrics/BlockLength
