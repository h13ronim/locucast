class Feed < ActiveType::Object
  attr_reader :upload

  def initialize(upload)
    @upload = upload
  end

  def title
    upload.name
  end

  def link
    'http://test.host/feeds/my_audiobook_name' # TODO
  end

  delegate :description, to: :upload

  def author
    'My Audiobook Author' # TODO
  end

  def items
    upload.uploaded_files.map do |uploaded_file|
      Feed::Item.new(uploaded_file, upload)
    end
  end
end
