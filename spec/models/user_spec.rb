require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }

  it { is_expected.to have_many(:uploads) }
end
