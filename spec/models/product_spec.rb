require 'rails_helper'

# bundle exec rspec spec/models/product_spec.rb
RSpec.describe Product do
  describe "Validations" do
    subject { build(:product) }
    it { is_expected.to validate_presence_of(:sku) }
    it { is_expected.to validate_uniqueness_of(:sku).case_insensitive }
  end

  describe "Assosiations" do
    it { is_expected.to belong_to(:supplier) }
  end

  describe "DB" do
    DB_COLUMN = %i[sku supplier_id field1 field2 field3 field4 field5 field6
                   price]
    DB_COLUMN.each do |db_column|
      it { is_expected.to have_db_column(db_column) }
    end
  end
end
