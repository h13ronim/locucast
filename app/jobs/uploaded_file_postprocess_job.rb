class UploadedFilePostprocessJob < ActiveJob::Base
  queue_as :default

  def perform(uploaded_file)
    uploaded_file.send(:postprocess)
  end
end
