# frozen_string_literal: true

require "rails_helper"

RSpec.describe ShoppingList, type: :request do
  # rubocop:disable RSpec/ExampleLength
  describe "GET #index" do
    it "shows all shopping lists" do
      shopping_list1 = create(:shopping_list)
      shopping_list2 = create(:shopping_list)

      get shopping_lists_path

      expect(response).to be_successful
      expect(response.body).to include(shopping_list1.name)
      expect(response.body).to include(shopping_list1.shopping_day.to_s)
      expect(response.body).to include(shopping_list2.name)
      expect(response.body).to include(shopping_list2.shopping_day.to_s)
    end
  end
  # rubocop:enable RSpec/ExampleLength

  describe "GET #new" do
    it "renders form" do
      get new_shopping_list_path

      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "renders form" do
      shopping_list = create(:shopping_list)

      get edit_shopping_list_path(shopping_list)

      expect(response).to be_successful
      expect(response.body).to include(shopping_list.name)
      expect(response.body).to include(shopping_list.shopping_day.to_s)
    end
  end

  describe "GET #show" do
    it "shows shopping list" do
      shopping_list = create(:shopping_list)

      get shopping_list_path(shopping_list)

      expect(response).to be_successful
      expect(response.body).to include(shopping_list.name)
      expect(response.body).to include(shopping_list.shopping_day.to_s)
    end
  end

  describe "POST #create" do
    let(:products) { create_list(:product, 2) }
    let(:send_email_value) { "1" }
    let(:params) do
      {
        shopping_list: {
          name: "Shopping List 1",
          shopping_day: Time.new.next_day(2),
          status: "pending",
          send_email: send_email_value,
          shopping_list_email_attributes: {
            send_date: Time.new.next_day(1),
            file_format: "csv",
            recipient: "email@example.com",
            was_send: false,
          },
          shopping_list_products_attributes: {
            "0": {
              product_id: products.first.id,
              quantity: 1,
            },
            "1": {
              product_id: products.second.id,
              quantity: 2,
            },
          },
        },
      }
    end

    it "creates new shopping list" do
      post shopping_lists_path params

      expect(response).to redirect_to(shopping_list_path(described_class.last))
      expect(described_class.all.count).to eq 1
      expect(described_class.last.products.count).to eq 2
      expect(described_class.last.shopping_list_email).not_to be_nil
    end

    context "when email not set" do
      let(:send_email_value) { "0" }

      it "doesn't create email for shopping list" do
        post shopping_lists_path params

        expect(described_class.last.shopping_list_email).to be_nil
      end
    end
  end

  # rubocop:disable RSpec/ExampleLength
  describe "PUT #update" do
    it "updates shopping list" do
      shopping_list = create(:shopping_list)
      product1 = create(:product)
      new_params = {
        shopping_list: {
          name: "New Shopping List Name",
          shopping_day: Time.new.next_day(2),
          status: "pending",
          send_email: "0",
          shopping_list_email_attributes: {
            send_date: Time.new.next_day(1),
            file_format: "csv",
            recipient: "email@example.com",
          },
          shopping_list_products_attributes: {
            "0": {
              product_id: product1.id,
              quantity: 1,
            },
          },
        },
      }

      put shopping_list_path(shopping_list), params: new_params

      expect(response).to redirect_to(shopping_list_path(shopping_list))
      expect(shopping_list.reload.products.count).to eq 1
      expect(shopping_list.reload.name).to eq "New Shopping List Name"
    end
  end
  # rubocop:enable RSpec/ExampleLength

  describe "DELETE #destroy" do
    it "destroy shopping list" do
      shopping_list = create(:shopping_list)

      delete shopping_list_path(shopping_list)

      expect(response).to redirect_to(shopping_lists_path)
      expect(described_class.all.count).to eq 0
    end
  end
end
