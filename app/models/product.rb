class Product < ApplicationRecord
  self.primary_key = 'sku'
  belongs_to :supplier, foreign_key: 'supplier_id', primary_key: 'supplier_id'
  validates :sku, presence: true, uniqueness: true
end
