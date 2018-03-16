require 'rails_helper'

# bundle exec rspec spec/controllers/suppliers_controller_spec.rb
RSpec.describe SuppliersController do
  let(:attr) { { name: "FakeName" } }
  let(:supplier) { create(:supplier) }

  describe "GET :index" do
    it "responds with status 200" do
      get :index
      expect(response).to have_http_status :success
    end
  end

  describe "GET :new" do
    it "responds with status 200 if new supplier was successfully created" do
      get :new
      expect(response).to have_http_status :success
    end
  end

  describe "POST :create" do
    before(:each) do
      post :create, params: { supplier: attr }
    end

    it "responds with status 302" do
      expect(response).to have_http_status 302
    end

    it "saves supplier into database" do
      expect(Supplier.count).to eq 1
    end

    it "redirect to suppliers_path" do
      expect(response).to redirect_to(suppliers_path)
    end
  end

  describe "PATCH :update" do
    before(:each) do
      patch :update, params: { id: supplier.id, supplier: attr }
      supplier.reload
    end

    it "responds with status 302 when product updates correctly" do
      expect(response).to have_http_status 302
    end

    it "updates attributes successfully" do
      expect(supplier.name).to eq attr[:name]
    end

    it "redirects to suppliers_path" do
      expect(response).to redirect_to(suppliers_path)
    end
  end

  describe "GET :products" do
    it "responds with status 200" do
      get :products, params: { id: supplier.id }
      expect(response).to have_http_status 200
    end
  end
end
