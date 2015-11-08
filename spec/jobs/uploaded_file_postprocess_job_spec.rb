require 'rails_helper'

RSpec.describe UploadedFilePostprocessJob, type: :job do
  let(:uploaded_file) { create(:uploaded_file) }

  it { is_expected.to be_processed_in :default }

  it 'runs postprocess on uploaded_file' do
    expect(uploaded_file).to receive(:postprocess)
    subject.perform(uploaded_file)
  end
end
