class ChangeSkuFieldTypeInProducts < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :sku, :integer
    add_column :products, :sku, :string
  end
end
