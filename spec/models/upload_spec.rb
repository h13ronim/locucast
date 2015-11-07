require 'rails_helper'

RSpec.describe Upload, type: :model do
  subject { create(:upload) }

  it { is_expected.to belong_to(:user) }

  it { is_expected.to have_many(:uploaded_files) }

  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:name) }
end
