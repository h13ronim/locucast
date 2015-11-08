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

  context 'when adding url with national characters' do
    let(:url) { 'http://www.詹姆斯.com/zażółć gęślą jaźń.mp3' }
    subject { build(:uploaded_file, url: url) }

    let(:vcr_chain_cassettes) { nil }

    it { is_expected.to be_valid }

    describe 'url after validation' do
      before { subject.valid? }

      it 'returns normalized url' do
        expect(subject.url).to eq(
          [
            'http://www.xn--8ws00zhy3a.com',
            'za%C5%BC%C3%B3%C5%82%C4%87%20g%C4%99%C5%9Bl%C4%85%20ja%C5%BA%C5%84.mp3'
          ].join('/')
        )
      end

      it 'returns denormalized name' do
        expect(subject.name).to eq('zażółć gęślą jaźń.mp3')
      end
    end
  end
end
