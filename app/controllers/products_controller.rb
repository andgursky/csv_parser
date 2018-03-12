class ProductsController < ApplicationController
  before_action :set_product, only: %i[show download]

  def create
    binding.pry
  end

  def update
    binding.pry
  end

  def show
    binding.pry
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

  def set_product
    @product = Product.find params['id']
  end
end
