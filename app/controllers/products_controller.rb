class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update]

  def new
    @product = Product.new(product_params)
  end

  def create
    @product = Product.new product_params
    @product.sku = generate_sku
    @product.save!
    redirect_to controller: :suppliers, action: :products,
      id: product_params['supplier_id']
  end

  def update
    @product.update_attributes(product_params)
    redirect_to controller: :products, action: :show, product: { sku: @product }
  end

  def index
    @products = Product.paginate(page: params['page'])
  end

  private

  def product_params
    params.require(:product).permit(:supplier_id, :field1, :field2, :field3,
                                    :field4, :field5, :field6, :price)
  end

  def set_product
    @product = Product.find params['product']['sku']
  end

  def generate_sku
    str = "00000000"
    id_str = (Product.count + 1).to_s
    if id_str.length < str.length
      str.insert(-(id_str.length + 1), id_str)[0, str.length - id_str.length]
    else
      str.insert(-5, id_str)[0, id_str.length]
    end
  end
end
