require 'rails_helper'

RSpec.describe Product, type: :request do

  describe 'GET #index' do
    it 'shows all products' do
      product1 = create :product
      product2 = create :product
      
      get products_path

      expect(response).to be_successful
      expect(response.body).to include(product1.name, product1.unit, product2.name, product2.unit)
    end
  end

  describe 'GET #new' do
    it 'renders form' do
      get new_product_path

      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'renders form' do
      product = create :product

      get edit_product_path(product)

      expect(response).to be_successful
      expect(response.body).to include(product.name, product.unit)
    end
  end

  describe 'GET #show' do
    it 'shows product' do
      product = create :product

      get product_path(product)
      
      expect(response).to be_successful
      expect(response.body).to include(product.name, product.unit)
    end
  end

  describe 'POST #create' do
    it 'creates new product' do
      params = { 
          product: { 
                      name: Faker::Food.ingredient, 
                      unit: Faker::Food.metric_measurement, 
                      product_type: 'fruit' 
                  } 
      }

      post products_path, params: params

      expect(response).to redirect_to(product_path(Product.first))
      expect(Product.all.count).to eq 1
    end
  end

  describe 'PUT #update' do
    it 'updates product' do
      product = create :product
      new_params = { product: { name: 'New name', unit: 'New unit', product_type: 'fruit' } }

      put product_path(product), params: new_params
      
      expect(response).to redirect_to(product_path(product))
      expect(product.reload.name).to eq 'New name'
    end
  end

  describe 'DELETE #destroy' do
    it 'destroy product' do
      product = create :product

      delete product_path(product)
      
      expect(response).to redirect_to(products_path)
      expect(Product.all.count).to eq 0
    end
  end
end
