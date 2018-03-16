require 'rails_helper'

# bundle exec rspec spec/jobs/upload_job_spec.rb
RSpec.describe UploadJob do
  before do
    allow(subject).to receive(:options).and_return(subject.uuid)
    allow_any_instance_of(described_class).to receive(:match_string).
      and_call_original
  end

  context 'when uploading suppliers.csv file' do
    let(:file_name) { "suppliers.csv" }
    let(:supplier) { create(:supplier) }

    subject do
      UploadJob.new("csv_file" => suppliers_file,
                    "file_name" => file_name)
    end

    let(:match_data) do
      subject.send(:match_string, suppliers_file.first.first, file_name)
    end

    it "matching data with regular expression when calling #match_string" do
      expect(subject).to receive(:match_string).with(suppliers_file.first.first,
                                                     file_name)
      subject.perform
    end

    it "returns MatchData after parsing and should have 'names' method" do
      expect(match_data).to_not be_nil
      subject.perform
    end

    it "should parse csv file with named groups" do
      expect(match_data).to respond_to(:names)
    end

    it "updates attributes if supplier exist" do
      allow(Supplier).to receive(:find_by).
        and_return(supplier)
      expect(supplier).to receive(:update_attributes)
      subject.perform
    end

    it "saves new product if supplier doesn't exist" do
      allow(Supplier).to receive(:find_by).and_return nil
      expect(Supplier).to receive(:create!)
      subject.perform
    end
  end

  context 'when uploading sku.csv file' do
    let(:file_name) { "sku.csv" }
    let!(:supplier) { create(:supplier) }
    let(:product) { create(:product, supplier_id: supplier.id) }

    subject do
      UploadJob.new("csv_file" => sku_file,
                    "file_name" => file_name)
    end

    let(:match_data) do
      subject.send(:match_string, sku_file.first.first, file_name)
    end

    it "matching data with regular expression when calling #match_string" do
      expect(subject).to receive(:match_string).with(sku_file.first.first,
                                                     file_name)
      subject.perform
    end

    it "returns MatchData after parsing and should have 'names' method" do
      expect(match_data).to_not be_nil
      subject.perform
    end

    it "should parse csv file with named groups" do
      expect(match_data).to respond_to(:names)
      subject.perform
    end

    it "updates attributes if product exist" do
      allow(Product).to receive(:find_by).
        and_return(product)
      expect(product).to receive(:update_attributes)
      subject.perform
    end

    it "saves new product if product doesn't exist" do
      allow(Product).to receive(:find_by).and_return nil
      expect(Product).to receive(:create!)
      subject.perform
    end
  end

  def suppliers_file
    [["s0001¦Supplier 1"]]
  end

  def sku_file
    [["00000001¦s0001¦field1¦field0684¦field0684¦field15¦field0684¦"\
      "field1¦10.25"]]
  end
end
