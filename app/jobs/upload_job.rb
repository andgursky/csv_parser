class UploadJob
  include Resque::Plugins::Status

  def perform
    file = options['csv_file']
    file_name = options['file_name']
    file.map do |i|
      match_data = i.first.match(uploaded_file_regexp(file_name))
      data_hash = match_data.names.map { |name| [name, match_data[name]] }.to_h
      case file_name
      when "suppliers.csv"
        Supplier.transaction do
          supplier = Supplier.find_by(supplier_id: data_hash['id'])
          if supplier
            supplier.update_attributes(data_hash)
          else
            Supplier.create!(data_hash)
          end
        end
      when "sku.csv"
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

  private

  def uploaded_file_regexp(type)
    { "suppliers.csv" => /(?<id>.+?)¦(?<name>.+?)$/,
      "sku.csv" => /(?<sku>.+?)¦(?<supplier_id>.+?)¦(?<field1>.+?)¦
    (?<field2>.+?)¦(?<field3>.+?)¦(?<field4>.+?)¦(?<field5>.+?)¦
    (?<field6>.+?)¦(?<price>.+?)$/x }[type]
  end
end
