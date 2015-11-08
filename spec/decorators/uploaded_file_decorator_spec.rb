require 'rails_helper'

RSpec.describe UploadedFileDecorator, type: :decorator do

  let(:name) { 'foo+bar.mp3'}
  let(:title) { 'Baz Quux' }
  let(:url) { "http://example.com/foo/#{name}" }
  let(:model) { build(:uploaded_file, url: url, title: title) }
  let(:uploaded_file) { described_class.new(model) }

  describe '#title_or_name' do
    subject { uploaded_file.title_or_name }

    it { is_expected.to eq('Baz Quux') }

    context 'when file is without title' do
      let(:title) { nil }

      it { is_expected.to eq('foo+bar.mp3') }
    end
  end

end
