require 'rails_helper'

# bundle exec rspec spec/models/product_spec.rb
RSpec.describe Supplier do
  describe "Validations" do
    subject { create(:supplier) }
    it { is_expected.to validate_presence_of(:supplier_id) }
    it { is_expected.to validate_uniqueness_of(:supplier_id) }
  end

  describe "Assosiations" do
    it { is_expected.to have_many(:products) }
  end

  describe "DB" do
    DB_COLUMN = %i[supplier_id name]
    DB_COLUMN.each do |db_column|
      it { is_expected.to have_db_column(db_column) }
    end
  end
end
