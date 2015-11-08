class Feed < ActiveType::Object
  attr_reader :upload

  delegate :description, :author, to: :upload

  def initialize(upload)
    @upload = upload
  end

  def title
    upload.name
  end

  def items
    upload.uploaded_files.map do |uploaded_file|
      Feed::Item.new(uploaded_file, upload)
    end
  end
end
