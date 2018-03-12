class SuppliersController < ApplicationController
  before_action :set_supplier, only: %i[show download]

  def index
    @suppliers = Supplier.paginate(page: params['page'])
  end

  def create
    binding.pry
  end

  def update
    binding.pry
  end

  private

  def supplier_params
    params.require(:supplier).permit(:supplier_id, :name)
  end

  def set_supplier
    @supplier = Supplier.find params[:id]
  end
end
