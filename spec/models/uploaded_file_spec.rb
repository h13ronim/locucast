require 'rails_helper'

RSpec.describe UploadedFile, type: :model do
  let(:url) { "https://locucast.s3.amazonaws.com/uploads/1446903042750-3rgk73jgxiyynwmi-0e9f013acee10d99d97dcd3d3bf8bed9/6-10x10.png" }
  subject { create(:uploaded_file, url: url) }

  it { is_expected.to belong_to(:upload) }

  it { is_expected.to validate_presence_of(:upload) }
  it { is_expected.to validate_presence_of(:url) }

  describe "#name" do
    it "returns extracted name from url" do
      expect(subject.name).to eq "10x10.png"
    end
  end
end
