require 'rails_helper'

describe Feed do
  let(:author) { 'My Audiobook Author' }
  let(:link) { "http://www.example.com/feeds/#{upload.id}.xml" }
  let(:name) { 'My Audiobook Name' }
  let(:description) { 'My Audiobook Description' }
  let(:upload) do
    create(
      :upload,
      name: name,
      description: description,
      author: author
    )
  end
  let(:uploaded_file_1) { create(:uploaded_file, upload: upload) }
  let(:uploaded_file_2) { create(:uploaded_file, upload: upload) }
  let(:feed) { described_class.new(upload) }

  before do
    upload.update(uploaded_files_order: [uploaded_file_2.id, uploaded_file_1.id])
  end

  it { expect(feed.title).to eq(name) }
  it { expect(feed.description).to eq(description) }

  it { expect(feed.author).to eq(author) }

  describe '#items' do
    let(:items) { feed.items }
    let(:item_1) { instance_double(Feed::Item) }
    let(:item_2) { instance_double(Feed::Item) }

    before do
      allow(Feed::Item).to receive(:new).with(uploaded_file_1, upload) { item_1 }
      allow(Feed::Item).to receive(:new).with(uploaded_file_2, upload) { item_2 }
    end

    it { expect(items).to be_an(Array) }
    it { expect(items.size).to eq(2) }

    it "returns items in order returned from Upload#uploaded_files_ordered" do
      expect(items).to eq([item_2, item_1])
    end
  end
end
