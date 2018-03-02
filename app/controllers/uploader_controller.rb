class UploaderController < ApplicationController
  require 'csv'

  def upload
    get_line_regexp = /(.+?)\\n/
    if params['file']
      if params['file'].headers =~ /suppliers/
        # check for existing record
        save_into_database :suppliers
        # redirect suppliers actions
        binding.pry
        redirect_to controller: :suppliers, action: :index
      elsif params['file'].headers =~ /sku/
        save_into_database :products
        binding.pry
        redirect_to controller: :products, action: :index
      end
    end
  end

  private

  def save_into_database(file_type)
    file = params['file'].open
    CSV.read(file).map do |i|
      match_data = i.first.match(uploaded_file_regexp(file_type))
      data_hash = match_data.names.map { |name| [name, match_data[name]] }.to_h
      case file_type
      when :suppliers
        Supplier.transaction do
          supplier = Supplier.find_by(supplier_id: data_hash['id'])
          if supplier
            supplier.update_attributes(data_hash)
          else
            Supplier.create!(data_hash)
          end
        end
      when :products
        Product.transaction do
          product = Product.find_by(sku: data_hash['sku'])
          if product
            product.update_attributes(data_hash)
          else
            Product.create!(data_hash)
          end
        end
      end
    end
  end

  def uploaded_file_regexp(type)
    { suppliers: /(?<id>.+?)¦(?<name>.+?)$/,
      products: /(?<sku>.+?)¦(?<supplier_id>.+?)¦(?<field1>.+?)¦
    (?<field2>.+?)¦(?<field3>.+?)¦(?<field4>.+?)¦(?<field5>.+?)¦
    (?<field6>.+?)¦(?<price>.+?)$/x }[type]
  end
end
