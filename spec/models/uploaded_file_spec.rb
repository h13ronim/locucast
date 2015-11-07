require 'rails_helper'

RSpec.describe UploadedFile, type: :model do
  subject { create(:uploaded_file) }

  it { is_expected.to belong_to(:upload) }

  it { is_expected.to validate_presence_of(:upload) }
  it { is_expected.to validate_presence_of(:url) }
end
