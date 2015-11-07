require 'rails_helper'

RSpec.describe UploadedFile, type: :model do
  let(:url) { "https://locucast.s3.amazonaws.com/uploads/1446903042750-3rgk73jgxiyynwmi-0e9f013acee10d99d97dcd3d3bf8bed9/10x10.png" }
  subject { create(:uploaded_file, url: url) }

  it { is_expected.to belong_to(:upload) }

  it { is_expected.to validate_presence_of(:upload) }
  it { is_expected.to validate_presence_of(:url) }

  describe "#name" do
    it "returns extracted name from url" do
      expect(subject.name).to eq "10x10.png"
    end
  end

  describe "#postprocess" do
    let(:url) { Rails.root.join('spec/fixtures/1984-01_64kb.mp3') }
    subject { create(:uploaded_file, url: url) }

    before do
      subject.send(:postprocess)
    end

    it { expect(subject.title).to eq('1984-01') }
    it { expect(subject.author).to eq('George Orwell R-(Frank Muller)') }
    it { expect(subject.guid).to eq('0b6b8524741a72d04861b022027834eec220086f336b86c2389c8946a03b6755') }
    it { expect(subject.duration).to eq(2643.461) }
    it { expect(subject.length).to eq(21147816) }
  end
end
