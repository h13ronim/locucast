require 'rails_helper'

describe Feed::Item do
  let(:title) { 'My Uploaded File Title' }
  let(:author) { 'My Uploaded File Author' }
  let(:guid) { 'My Uploaded File GUID' }
  let(:position) { 1 }
  let(:duration) { 149 }
  let(:url) { 'http://test.host/feeds/my_audiobook_name/0001.mp3' }
  let(:length) { 22348423 }
  let(:file_type) { 'audio/mp3' }

  let(:uploaded_file) do
    create(
      :uploaded_file,
      title: title,
      author: author,
      guid: guid,
      position: position,
      duration: duration,
      url: url,
      length: length,
      file_type: file_type,
    )
  end

  before do
    pending 'We need to add post-processing fields to uploaded_files table'
  end

  let(:feed_item) { described_class.new(uploaded_file) }

  it { expect(feed_item.title).to eq(title) }
  it { expect(feed_item.author).to eq(author) }
  it { expect(feed_item.guid).to eq(guid) }
  it { expect(feed_item.position).to eq(position) }
  it { expect(feed_item.duration).to eq(duration) }
  it { expect(feed_item.enclosure_url).to eq(url) }
  it { expect(feed_item.enclosure_length).to eq(length) }
  it { expect(feed_item.enclosure_file_type).to eq(file_type) }
end
