class Feed::Item < ActiveType::Object
  attr_reader :uploaded_file, :upload

  def initialize(uploaded_file, upload)
    @uploaded_file = uploaded_file
    @upload = upload
  end

  delegate :title, :author, :guid, :position, :duration, to: :uploaded_file
  delegate :url, :length, to: :uploaded_file, prefix: :enclosure

  def image
    '' # TODO
  end

  def pub_date
    upload.created_at.at_beginning_of_day.advance(minutes: position)
  end

  def enclosure_file_type
    MIME::Types.type_for(uploaded_file.url).first.content_type
  end

  def items
    uploaded_file.uploaded_fileed_files.map do |uploaded_fileed_file|
      Feed::Item.new(uploaded_fileed_file)
    end
  end
end
