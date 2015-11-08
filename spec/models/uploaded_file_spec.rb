require 'rails_helper'

RSpec.describe UploadedFile, type: :model do
  subject { create(:uploaded_file) }

  include_context :vcr_chain
  let(:vcr_chain_cassettes) { :upload_url_mp3 }

  it { is_expected.to belong_to(:upload) }

  it { is_expected.to validate_presence_of(:upload) }
  it { is_expected.to validate_presence_of(:url) }

  describe "#name" do
    it "returns extracted name from url" do
      expect(subject.name).to eq('fables_01_01_aesop_64kb.mp3')
    end
  end

  describe "#postprocess" do
    subject { create(:uploaded_file) }

    before do
      subject.send(:postprocess)
    end

    it { expect(subject.title).to eq('The Fox and The Grapes') }
    it { expect(subject.author).to eq('Aesop') }
    it { expect(subject.guid).to eq('f19f86d2658f39c64187492903c0100a846fa63a72131574f20f49257959c9da') }
    it { expect(subject.duration).to eq(46.628375) }
    it { expect(subject.length).to eq(373155) }
  end
end
