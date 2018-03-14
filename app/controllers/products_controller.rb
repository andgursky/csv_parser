class ProductsController < ApplicationController

  def new
    @product = Product.new
  end

  def create
    binding.pry
  end

  def edit
  end

  def update
    binding.pry
  end

  def show
    @supplier_products = Supplier.find(params['id']).products.
      paginate(page: params['page'])
  end

  def index
    @products = Product.paginate(page: params['page'])
  end

  def upload
    binding.pry
  end

  private

  def product_params
    params.require(:product).permit(:sku, :supplier_id, :fild1, :fild2,
                                    :fild3, :fild4, :fild5, :fild6, :price)
  end
end
