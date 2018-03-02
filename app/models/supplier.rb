class Supplier < ApplicationRecord
  self.primary_key = 'supplier_id'
  has_many :products, foreign_key: 'supplier_id', primary_key: 'supplier_id',
                      dependent: :destroy
  validates :supplier_id, presence: true, uniqueness: true
end
