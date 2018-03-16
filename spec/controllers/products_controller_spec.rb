require 'rails_helper'

# bundle exec rspec spec/controllers/supplier_controller_spec.rb
RSpec.describe ProductsController, type: :controller do
  let(:supplier) { create(:supplier) }

  describe "GET :new" do
    it "responds with status 200 if new product was created" do
      get :new, params: { product: { supplier_id: supplier.id } }
      expect(response).to have_http_status :success
    end
  end

  describe "GET :index" do
    it "responds with status 200" do
      get :index
      expect(response).to have_http_status :success
    end
  end

  describe "PATCH :update" do
    let(:product) { create(:product, supplier_id: supplier.id) }
    let(:attr) { { sku: product.sku, price: 123 } }

    before(:each) do
      patch :update, params: { id: product, product: attr }
      product.reload
    end

    it "responds with status 302 when product updates correctly" do
      expect(response).to have_http_status 302
    end

    it "updates attributes successfully" do
      expect(product.price).to eq attr[:price]
    end

    it "redirects to SuppliersController action :products" do
      expect(response).to redirect_to(controller: :products, action: :show,
                                     product: { sku: product })
    end
  end

  describe "POST :create" do
    before(:each) do
      post :create, params: { product: { supplier_id: supplier.id } }
    end

    it "responds with status 302" do
      expect(response).to have_http_status 302
    end

    it "saves product into database" do
      expect(Product.count).to eq 1
    end

    it "redirects to SuppliersController action :products" do
      expect(response).to redirect_to(controller: :suppliers, action: :products,
                                      id: supplier.id)
    end
  end
end
