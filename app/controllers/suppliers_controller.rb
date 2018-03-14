class SuppliersController < ApplicationController
  before_action :set_supplier, only: %i[show edit update products]

  def index
    @suppliers = Supplier.order(:id).paginate(page: params['page'])
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(supplier_params)
    @supplier.supplier_id = generate_id
    @supplier.save!
    redirect_to suppliers_path
  end

  def update
    @supplier.update_attributes(supplier_params)
    redirect_to suppliers_path
  end

  def products
    @supplier_products = Supplier.find(params['id']).products.order(:sku).
      paginate(page: params['page'])
  end

  private

  def supplier_params
    params.require(:supplier).permit(:name)
  end

  def set_supplier
    @supplier = Supplier.find params[:id]
  end

  def generate_id
    str = "s0000"
    id_str = (Supplier.count + 1).to_s
    if id_str.length < str.length
      str.insert(-(id_str.length + 1), id_str)[0, str.length - id_str.length]
    else
      str.insert(-5, id_str)[0, id_str.length + 1]
    end
  end
end
