class UploaderController < ApplicationController
  require 'csv'

  def upload
    if params['file']
      UploadJob.create(csv_file: CSV.read(params['file'].open),
                       file_name: params['file'].original_filename)
    end
  end
end
